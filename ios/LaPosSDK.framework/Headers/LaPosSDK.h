//
//  LaPosSDK.h
//  SDK
//  Copyright (c) 2018, GeoPagos.
//  All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 */
@interface LaPosSDK : NSObject

/**
 Callback informando el resultado de las operaciones
 
 @param resultInfo Un diccionario con el resultado. Su contenido depende
 de la operación realizada. Si `success` = `false`, puede contener una clave `error`
 con un `NSError` informando el error.
 @param success Informa si la operación fue completada exitosamente.
 */
typedef void(^LPOperationCompletion)(NSDictionary* _Nullable resultInfo, BOOL success);

/**
 Instancia de LaPosSDK para operar.
 */
+ (instancetype) sharedSDK;

/**
 Inicializa el SDK. Llamar junto con `-[LaPosSDK setUserToken:]` antes de usar el SDK,
 por ejemplo en `-[UIApplicationDelegate application:didFinishLaunchingWithOptions:]`
 */
- (void) startWithAPIKey:(NSString*)apiKey;

/**
 Elige el token de usuario. Operaciones posteriores usarán este token.
 
 @param userToken El token de sesión asignado
 */
- (void) setUserToken:(NSString*)userToken;

/**
 Comienza el proceso de cobro.
 
 @param amount Cantidad a cobrar.
 @param description Descripción de la compra para mostrar en el recibo.
 @param viewController `UIViewController` en donde presentar la pantalla de cobro.
 @param completion Callback al terminar de cobrar, con un diccionario
 con el resultado.
 */
- (void) chargeAmount:(CGFloat)amount
          description:(nullable NSString*)description
presentFromViewController:(UIViewController *)viewController
           completion:(LPOperationCompletion)completion;

/**
 Comienza el proceso de cobro.
 
 @param amount Cantidad a cobrar.
 @param reference Referencia opcional de la operación. Para ser usado
 en `-[LaPosSDK retrievePaymentInfoForReference:completion:]`.
 >Debe ser único dentro de cada desarrollador.
 @param description Descripción de la compra para mostrar en el recibo.
 @param viewController `UIViewController` en donde presentar la pantalla de cobro.
 @param completion Callback al terminar de cobrar, con un diccionario
 con el resultado.
 */
- (void) chargeAmount:(CGFloat)amount
            reference:(nullable NSString*)reference
          description:(nullable NSString*)description
presentFromViewController:(UIViewController *)viewController
           completion:(LPOperationCompletion)completion;

/**
 Color principal de la aplicación.
 */
@property (nonatomic, copy, nonnull) UIColor *mainColor;

/**
 Envía un recibo por email. El usuario debe estar autenticado previamente.
 
 @param operationId Identificador de la operación.
 @param email Dirección de email a donde enviar el recibo.
 @param completion Callback al enviar el recibo.
 */
- (void) sendReceiptForOperationID:(NSString *)operationId
                           toEmail:(NSString *)email
                        completion:(LPOperationCompletion)completion;

/**
 Genera un PDF del recibo. Se puede usar `UIPrintInteractionController` para imprimirlo.
 El usuario debe estar autenticado previamente.
 
 @param operationId Identificador de la operación.
 @param completion Callback al generar el recibo, con el recibo en la clave `receipt` del diccionario.
 */
- (void) getPDFReceiptForOperationID:(NSString *)operationId
                          completion:(LPOperationCompletion)completion;

/**
 Obtiene información sobre una transacción.
 
 @param operationId Identificador de la oparación.
 @param completion Callback con la información de la transacción.
 */
- (void) retrievePaymentInfoForOperationID:(NSString *)operationId
                                completion:(LPOperationCompletion)completion;

/**
 Obtiene información sobre una transacción.
 
 @param reference Referencia de la oparación.
 @param completion Callback con la información de la transacción.
 */
- (void) retrievePaymentInfoForReference:(NSString *)reference
                              completion:(LPOperationCompletion)completion;

/**
 Comienza el proceso de devolución de una venta.
 
 @param operationId Identificador de la operación a devolver.
 @param partialEnabled Permitir al usuario ingresar un monto parcial a devolver.
 @param viewController `UIViewController` en donde presentar la pantalla de devolución.
 @param completion Callback al finalizar, con un diccionario con el resultado.
 */
- (void) refundOperationID:(NSString *)operationId
       enablePartialAmount:(BOOL)partialEnabled
 presentFromViewController:(UIViewController *)viewController
                completion:(LPOperationCompletion)completion;

@end

NS_ASSUME_NONNULL_END
