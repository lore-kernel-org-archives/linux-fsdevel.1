Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033AA175A87
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903889; cv=fail; b=pUqlySUFT248avux7N9uzWiA2RPKHUtUFRrBUI5BHSImSx5iNNnkz3gtadsloma2B0Ieb6PJmYitrZWcHpAJweCmF5GTJGkEBv77t5us0Y4DdO8m/3Q8h3V/q8k6LY3HANEYwmXH/g+ezmS7mKNzHcFOb5CqoswP4SMFaCRR/vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903889; c=relaxed/simple;
	bh=+jC2H976XplNs4iKYu0vcSaXvwiYrG1ntaDGdpOxb0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUC2Pf4Na1KBONYcnQVxTIqzztU7JDKwWcL/dKMW3WWvuwBA8/rFtvge5EYIMvotpxhzo+Bj8xSB9aRoJlNoguSbVMLrLvuOPeiBXR02ukxgCI03j+7pgi9P24lGm4n6utO/nUUqzCMdZM8MylpjBY9n7fefmrSUql0oWTSjoms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UYfQ1S7N; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UYfQ1S7N"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021097.outbound.protection.outlook.com [40.107.208.97]) by mx-outbound23-217.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 30 Mar 2026 20:51:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv0hPzPoOCsft06cr12ssPauuyTzrcJkEk6ruqsSDFiVfvKbjK9AKqr/xrZwFrXZUdNFG8FMrkXmes0fPwkdjMOgy87JNKERPhCTfhpw+4zEsvgK701WXFut55xyqX7W2sC/LasEh+R5E7h2m+qF5DOvEH/S3Gc3J+7HP9SEbIllpxfJtEmtSs8L+UyyjnVYYA6o/xoLRpo3f3Wv5M89Xh9U819FBAsqlITQQcOYaczOsv2659LDkDNTsIRskLuNagFJmye8xkmqNn9Vo/ftEkI2lNqKbnZcJ6DBL7A5yJA4KMZx3tNhWccAmAvjZ9dH5Du/12LQG9T9Zc1NF+8Ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jC2H976XplNs4iKYu0vcSaXvwiYrG1ntaDGdpOxb0I=;
 b=OFYdEQLUMo8OgCdgyjOuo8sxwpjkRZ+utshxFr6CltJcullcvtJytQkmUHCGwclwEYb7pGcrc+UQYsNQM4YkhW5ccMX0d62lW6/FGrM3AG7jNSMQ7JYiArOsOLSJ1xrIC2ccvE2HORGrJtIyFVCK8LU1Mk9CnMN+5pKR13lJYFSLyl6iMGNToRZxalQ1YyNdy6M+4Y/6cpaJf9nWRW7WW3g7fvgKA0mHZlwFLeO29B/j9ARDchDtAmmfehKP64ZROWgSbMS0IFhdPEkJDY0VNJaqldUIEeArNrGeSoX1PPSk2+7U1vW6QU3ZfkxrmHjBr1OL0kDeeThAlrVPPlistQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jC2H976XplNs4iKYu0vcSaXvwiYrG1ntaDGdpOxb0I=;
 b=UYfQ1S7N5tzMQfs7tm8peOZJry+6S1rcN0zBgU6xtJ+FmiH7I/mpPNcmVz/JdXytPU/X0LkYoSCucq0AiTVkdpKF3E3odNDftZsfH2JvoP/vNkUEE/7LxOqTFfgmP4H+8G/pB5RNDpadgEjdhsDwd+ozXw5KMIDJplb42ngzWkc=
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by PH0PR19MB5068.namprd19.prod.outlook.com (2603:10b6:510:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 20:51:02 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b%6]) with mapi id 15.20.9745.024; Mon, 30 Mar 2026
 20:51:01 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bernd@bsbernd.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "neal@gompa.dev" <neal@gompa.dev>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>
Subject: Re: [PATCH 03/17] mount_service: create high level fuse helpers
Thread-Topic: [PATCH 03/17] mount_service: create high level fuse helpers
Thread-Index: AQHcvYig7N9IpwcOD0ShnF4ulLAc8rXHfisAgAAOwoCAAAXXgA==
Date: Mon, 30 Mar 2026 20:51:01 +0000
Message-ID: <095a92b6-889d-4207-8aa5-7b76098a3937@ddn.com>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463171.1008428.692188550544402497.stgit@frogsfrogsfrogs>
 <d7e830f2-fb3f-4782-a6bc-9b850ebdcc36@bsbernd.com>
 <20260330203007.GJ6254@frogsfrogsfrogs>
In-Reply-To: <20260330203007.GJ6254@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3872:EE_|PH0PR19MB5068:EE_
x-ms-office365-filtering-correlation-id: 2f7c4c0b-7b24-4101-4af1-08de8e9e0dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|19092799006|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info:
 ax1ci4CzmTXpIFJF9yJhTB7ESWtPnDzWvVfgGPOF1jEywvDuBYU4E40JnqVrMqZnO8NSZhR+ilJU6vbJxcWljHtHBvq7kmmgZlzvK2hdqf2Fb5l6Bvgl662+9mGrgGZX7mSxwfxAuMGtB+P9+yVGDMv8bzzSNQT9GprZytZvJPHaPgOb15TyTyibhBt4xpFdz8dXft7Tor8l4LCyr2orkWaaQC+UyyzP+1aT08cLacvzUmbRG/b6ervS+BmFwy0M3PEQjFxZYmqTs/CIeLaGpp/r01sCYcVGkBl7B1xMsfbhtEN4KI1HWw1oTvqpOvI6hEWFUaHLF9umvaHcTNgIV0g3inwayD9srB0e+K5IGSfxdmdp94vEGCzA0JxAuH7iBj84HYDYhYTKASmQ3NRpRaCHV8DlRapxoJFY7DWP6fkpidiuHt5jUk/xPx6IUjrRnAkTre0XbqyYsonRqRByjkM2reWkGAq1VveDj44w6arS/MTkjl58YXDIgEKnTOTcgbm7pG3wWWKceVckLmtXzyqD1it/x4sMIjjbvlUz/2LqpQvmGOVmV3P0yRCtv5JfhX397vHVlWksIRWvOhijeo+P1K17OitsJi8bF/wOoa2vMB4qqxYjfQ9tVN3A48HpEGXT93HVTcV+Bx0xkzQxN8zuaX4XnqxBk7K3cUbF24FqanNMK22eOKLnbHNXDTLdVPtWSiEWbA29QT9fGOqEkQylmJHXim+3sgsA7iJvBJAWT+5h1Rj5Eirz7vVHGPkY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(19092799006)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVJ2aGc3eVdURWFlUUpvTWxaZkt3SmtVSVQ4Q090MEp0N2RhZVNNNysyWUtr?=
 =?utf-8?B?ZitzeVFwVHhQYnQzYnV3TkNld0MyOGxlODVOS1lOOXhzdlFqbVhwV0tQWmhR?=
 =?utf-8?B?cFRTVis5TGdKSDFSZWtnaEJmM0p1akxTZElJeTlsK1R3dEFoMy9ISWs0SXRS?=
 =?utf-8?B?QXhDQjJvM1o3dXpiSHFIZkk5OVVtVkYvS3loZVI2M2RidFh5Q083SkxQUEJm?=
 =?utf-8?B?VDJ2TkNsRUZvY0trWk5LU0VrdW01L1Q1TExJajExZjU2UzFTNWJIU0J3V2I4?=
 =?utf-8?B?WWV3QUE1bDFUUG5MMFhydHdhWDd1cHkrZjJqcmhIWFlGWFZBWWtRMGE4NXVj?=
 =?utf-8?B?UFJOcVJWa3RNOTJqS2NUQWRoMWxCcFV5S1B4R2VmRWM2UzdZYWZwZzhzMUlC?=
 =?utf-8?B?ZGFwd0lCNDhlVWRnZGlOZm5KbHJzSmozdWo3QkVxQ3RtWEpIZy85UzZOVlBw?=
 =?utf-8?B?YzdoaU9kL2J2V3VDdk5TK0xkUnlrOVBNV0xLK2hDekswL0JQbFdGTWlQMW1o?=
 =?utf-8?B?cHQ4Szg0Z0RxUnE1d3dPOGc4V2hsKzJ4djVGNkhpV1IrcWZBOE1Eb2xkcGRz?=
 =?utf-8?B?dXdseFFnUnlQVlAyYldRSGVGVWprWDNLWW0ycEV4RDlrMVdLaWNPS2tpR0pT?=
 =?utf-8?B?bFN1TjZxckQ0cUtGOUxtaUg2TGN3WmZVekRSdTN3Y1M2aG9uZGdLWUczYmVM?=
 =?utf-8?B?UlF4cGkzcG43ZVM5YUlPNzdKMzVCdG5PTWx6UWlxUi9tWi9uQUk2NURkL2FC?=
 =?utf-8?B?M0QvOHZwQ0QyQWN3Z1FkT2lrTXlqQmZScm5JOXJkM2hvajNIQTBONlZsTWNt?=
 =?utf-8?B?WWFGOU81SmF3ZU9xWUZWZkwrZ3R3T3o0bVVEWUY1WFdKWXhIZ0wyc01uOWVt?=
 =?utf-8?B?NDY3NUN5REoyZDkxWUdBdTlrTTZCQWx1eVJjNVhBY2EzZysrdGtvbVM0U1Vw?=
 =?utf-8?B?Um5sbmVmbnBMQlQzMkw0STNwYTlybWJ5NmNaQmJyVHpBWE1jcmM0clVTd1g1?=
 =?utf-8?B?NWY0c21KZ0Z2Z1RLeGdDQ3hTOC96bm1zM3A0SjJ5S2tlRVBnWElsREg2VnJT?=
 =?utf-8?B?NWlZSlRuTVI4RHRlVVBNOU5HU1FRZEZQbXhMV29RUnJxL0NmUTBZWDMxdUts?=
 =?utf-8?B?M3Uyb29VMXJ6K3RzR0d5ek9yVENYdUdCQnRMeTJxN1JQRDhZWHlvMjJFU1gw?=
 =?utf-8?B?VXpoQWhETmZ6MVNsMVZtYkR3U1ZHTldjaGQySHVyd2pDYmdrazFqcDUvUjE1?=
 =?utf-8?B?ZnF1emdKNU5wQStGSVJ6cEJyUzhRSm5md0Y3V2Z2VWF1WHpCeThQRC9FeU9a?=
 =?utf-8?B?R3FCdjhNQko4bmVkYXRwZlZBRXFTb1RtakdqRkRPUVZvcVRZbk1OMVVBTG12?=
 =?utf-8?B?ZklWYncvdkZMTHNKUHlDL2pTWHVmbG1BYjJBZG1OSWJIbE1iaHg3OEZZajcy?=
 =?utf-8?B?WTliNlZONW11L3dSMTR1T3VQTkJQbXREUTltTms5RjBGeXhEZGovS0JOOStX?=
 =?utf-8?B?OHNJTjlrMFNYQjhPNUw2ZG1xSjZUWE5mL0s5dVJpVngxSUFzOUFzSkFhVDlj?=
 =?utf-8?B?TFFoWXkwVTh6QTVuNExsaGZoeHBTemlraDRtUWswT0xEajdyQm0zT1ZjVXVC?=
 =?utf-8?B?RmsyZlQ5VHJEd2JiZVlyaDdrYW82UnhIWitrV09sQWUwQ1JvQmxnbkRzTFZv?=
 =?utf-8?B?c3ZHQXFFYngrOHRJdHdqWm1FTEVlSGY3cFNNODlYcm9JeTlYRGtYS3BPR2FE?=
 =?utf-8?B?d1l3K1BXenlrRllxaWdnamRXUlUxZ2cxb0R4SjFPam83Yk5qY0w4emppak1s?=
 =?utf-8?B?TGZpQUV6azJPSUhXSk5pUXVITWgxcGRsS014My8vcDJaMHY1RFZNckRnZXI4?=
 =?utf-8?B?empmQkpJaFlQTDhBdnJuZU1PcTdzMm1KRzN2RzVDd1ZKNWltdjlDTitjVGRE?=
 =?utf-8?B?b1hmOHR1S3NtLy9jOGlDdThmWmMwVDFDTGQ4bWRBdkRHMEExQWtFa3JzYmww?=
 =?utf-8?B?YndlOTZ6V3RjZXEzRnhMLzdKczVzM1BGT2dlVlJ1ZFpOSDRaSGR3MzR1dzN4?=
 =?utf-8?B?SW54cGI1WkljMDJVQnFJazNNMlNQQUl5bzc4b1RwNWNCVGVrcWpPQThYWnpx?=
 =?utf-8?B?c05rZ3dabkIrMVVNTzVIOExncjlCd0w2cnBZajFoNG04eFIxMzdYbFIzeGh2?=
 =?utf-8?B?SmxRdzZ5Y1B2QkhNZk00eDcveDdobnN3Qnh0QTFha0QzUk00REFhRHc2UlN2?=
 =?utf-8?B?d0I4dC8rK096YUJObm9IRVFtcTArN1hXYXNjSDV0enJnek5VZ3lSSHBielVh?=
 =?utf-8?B?T2lRaWpNaE00OUJoaldhOWRFTWI1MVRpcFBoUDdyTnNhd3VveVk0RHhBa0dl?=
 =?utf-8?Q?3CRjE77nhXrPwIQaykq9coRlUjifr/tBrnQA2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F69B24ADF236B84CA61939D560BF34FA@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nEdb5zP4GIOFx60Ja0R42vJGcEBYcChXUxJLsOSYvXfZtnd5HM8BRCbBN/Ja9U7tZqsenxDHwa/VZV6LZzu2OTb6A81nFzjwogWJCmPVRTWgW6zKq7VAg6VqndedJgyb59xV4QIW35Bb7CXYEXY0K+Icr54XxxkA9rkiiziz8oOeh0e5LtjraeblW0fRtOq8/d9WAxtS/Nx70jh35hfB/7nVBT6B5Bj2MF0bsLMceZJV1schMX1IFDUwNAc1wJdfz1QIVX///31BfGGQ9LCuAQFaiU37wh/RPEo2rJfhXMe86mtRTcxpWAgJ6qtV0ps6tOOQ/UWe52OaVzdg5Yi4iQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yApZ7pXM5RbNyyzN2jwsVrHmMPiD+jx4ptUuqEsXVLkbqf4iylKnkD4NTJb5ITcGD38hIAV4Aj5vcHnRloeHyepeLUHx5+/3f/59dnP4FkaYiSVmHhtmgOzHU/VBb0vh/1rZ7PKxI11k4JCZSuhuYpBbd0f+2AgKqUicssmLM95gtCLz18Ipgj3IIn+FuiOjDic0PcfaiyJRQsXgt4UgSlG0Pt9OtWneng5S2gU5GZLm7DSvogJT5vuzcerSaXWPvEZ3opPn2YOseTQ15UHkLmXBKwkxCTOacwG85QANHmr4TVZ8HQ8jglNZa3TORLm0Woqko6tkgk1x+z2rIGu5hQ+X9EbwWWaoW4nLV7hsyN3u/y3sLO0UZeukTuhM0AH0gYOgmcWZYItJYibUoIsJTO5AX1O9iIqeWtWfHnApjzcPW7aRWjxZyhUzTozFHTBLfbeSuxxR0/M7YiLObsE20EAblJFxJpV0S0laYr7HjEw+bo10NO1wM2eaCi9NwB4hXbjvKw0HTUrbvHDWOSRC2ce8MMMF2yAooHA+Y+wdJ+6NlY/tpQSKolu/YY931j+7gIaZKUls3qkKWVptqMl6MA34//bmUMhfiZuqx3NYosRubOjUxPhyk5x6mhZQFkNisTAAdFAtGXLm/mn/vr+68g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7c4c0b-7b24-4101-4af1-08de8e9e0dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 20:51:01.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oF4+XdJpP+rbtF6RSq/ObrOYc26479phIF+rncliP0fqbN3iwy1aUyPcSNqLKVIwABEyBfEX2g0jHbGSV6z7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5068
X-BESS-ID: 1774903865-106105-27974-9394-1
X-BESS-VER: 2019.1_20260324.1831
X-BESS-Apparent-Source-IP: 40.107.208.97
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYmJpZAVgZQ0NA4ydzIJCXJMN
	koxdIoydwsKTnZNCklMcnM0NIg0cREqTYWAGtPH4lBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272187 [from 
	cloudscan9-29.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMy8zMC8yNiAyMjozMCwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBPbiBNb24sIE1hciAz
MCwgMjAyNiBhdCAwOTozNzoxOFBNICswMjAwLCBCZXJuZCBTY2h1YmVydCB3cm90ZToNCj4+IEhp
IERhcnJpY2ssDQo+Pg0KPj4gT24gMy8yNy8yNiAwMjoyNSwgRGFycmljayBKLiBXb25nIHdyb3Rl
Og0KPj4+IEZyb206IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+Pj4NCj4+
PiBDcmVhdGUgYSBmdXNlX21haW4gd3JhcHBlciBmb3IgZnVzZSBzZXJ2aWNlcy4NCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+Pj4g
LS0tDQo+Pj4gIGluY2x1ZGUvZnVzZS5oICAgICAgICAgfCAgIDMzICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+PiAgbGliL2Z1c2VfdmVyc2lvbnNjcmlwdCB8ICAgIDEgKw0KPj4+ICBs
aWIvaGVscGVyLmMgICAgICAgICAgIHwgICA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0NCj4+PiAgMyBmaWxlcyBjaGFuZ2VkLCA4MyBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9m
dXNlLmggYi9pbmNsdWRlL2Z1c2UuaA0KPj4+IGluZGV4IDU5NWNhYzA3ZjJiZTM2Li5jN2RhZTA0
MDg1N2FjYSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2Z1c2UuaA0KPj4+ICsrKyBiL2luY2x1
ZGUvZnVzZS5oDQo+Pj4gQEAgLTEwMDgsNiArMTAwOCwzOSBAQCBzdGF0aWMgaW5saW5lIGludCBm
dXNlX21haW5fZm4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSwNCj4+PiAgI2RlZmluZSBmdXNlX21h
aW4oYXJnYywgYXJndiwgb3AsIHVzZXJfZGF0YSkgXA0KPj4+ICAJZnVzZV9tYWluX2ZuKGFyZ2Ms
IGFyZ3YsIG9wLCB1c2VyX2RhdGEpDQo+Pj4gIA0KPj4+ICsjaWYgRlVTRV9NQUtFX1ZFUlNJT04o
MywgMTkpIDw9IEZVU0VfVVNFX1ZFUlNJT04NCj4+PiArc3RydWN0IGZ1c2Vfc2VydmljZTsNCj4+
PiAraW50IGZ1c2Vfc2VydmljZV9tYWluX3JlYWxfdmVyc2lvbmVkKHN0cnVjdCBmdXNlX3NlcnZp
Y2UgKnNlcnZpY2UsDQo+Pj4gKwkJCQkgICAgIGludCBhcmdjLCBjaGFyICphcmd2W10sDQo+Pj4g
KwkJCQkgICAgIGNvbnN0IHN0cnVjdCBmdXNlX29wZXJhdGlvbnMgKm9wLA0KPj4+ICsJCQkJICAg
ICBzaXplX3Qgb3Bfc2l6ZSwNCj4+PiArCQkJCSAgICAgc3RydWN0IGxpYmZ1c2VfdmVyc2lvbiAq
dmVyc2lvbiwNCj4+PiArCQkJCSAgICAgdm9pZCAqdXNlcl9kYXRhKTsNCj4+PiArDQo+Pj4gKy8q
Kg0KPj4+ICsgKiBTYW1lIGFzIGZ1c2Vfc2VydmljZV9tYWluX2ZuLCBidXQgdGFrZXMgaXRzIGlu
Zm9ybWF0aW9uIGZyb20gdGhlIG1vdW50DQo+Pj4gKyAqIHNlcnZpY2UgY29udGV4dC4NCj4+PiAr
ICovDQo+Pj4gK3N0YXRpYyBpbmxpbmUgaW50IGZ1c2Vfc2VydmljZV9tYWluX2ZuKHN0cnVjdCBm
dXNlX3NlcnZpY2UgKnNlcnZpY2UsDQo+Pj4gKwkJCQkgICAgICAgaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSwNCj4+PiArCQkJCSAgICAgICBjb25zdCBzdHJ1Y3QgZnVzZV9vcGVyYXRpb25zICpvcCwN
Cj4+PiArCQkJCSAgICAgICB2b2lkICp1c2VyX2RhdGEpDQo+Pj4gK3sNCj4+PiArCXN0cnVjdCBs
aWJmdXNlX3ZlcnNpb24gdmVyc2lvbiA9IHsNCj4+PiArCQkubWFqb3IgID0gRlVTRV9NQUpPUl9W
RVJTSU9OLA0KPj4+ICsJCS5taW5vciAgPSBGVVNFX01JTk9SX1ZFUlNJT04sDQo+Pj4gKwkJLmhv
dGZpeCA9IEZVU0VfSE9URklYX1ZFUlNJT04sDQo+Pj4gKwkJLnBhZGRpbmcgPSAwDQo+Pj4gKwl9
Ow0KPj4+ICsNCj4+PiArCXJldHVybiBmdXNlX3NlcnZpY2VfbWFpbl9yZWFsX3ZlcnNpb25lZChz
ZXJ2aWNlLCBhcmdjLCBhcmd2LCBvcCwNCj4+PiArCQkJCQkJc2l6ZW9mKCoob3ApKSwgJnZlcnNp
b24sDQo+Pj4gKwkJCQkJCXVzZXJfZGF0YSk7DQo+Pj4gK30NCj4+PiArI2RlZmluZSBmdXNlX3Nl
cnZpY2VfbWFpbihzLCBhcmdjLCBhcmd2LCBvcCwgdXNlcl9kYXRhKSBcDQo+Pj4gKwlmdXNlX3Nl
cnZpY2VfbWFpbl9mbihzLCBhcmdjLCBhcmd2LCBvcCwgdXNlcl9kYXRhKQ0KPj4+ICsjZW5kaWYg
LyogRlVTRV9VU0VfVkVSU0lPTiA+PSBGVVNFX01BS0VfVkVSU0lPTigzLCAxOSkgKi8NCj4+DQo+
PiBzb3JyeSwgdGhpcyBpcyBub3QgZXhhY3RseSB3aGF0IEkgbWVhbnQuIENvdWxkIHlvdSB0YWtl
IGEgbG9vayBoZXJlPyBJDQo+IA0KPiBPSCwgeW91IHdhbnQgdGhlIHByb2dyYW0gdG8gcGFzcyBp
biBib3RoIHRoZSB2ZXJzaW9uIG9mIGxpYmZ1c2UgdGhhdCB0aGUNCj4gcHJvZ3JhbSB3YXMgYnVp
bHQgYWdhaW5zdCAoc3RydWN0IGxpYmZ1c2VfdmVyc2lvbikgYW5kIHRoZSB2ZXJzaW9uIG9mDQo+
IGxpYmZ1c2UgdGhhdCB0aGUgcHJvZ3JhbSBhc2tlZCBmb3IgKEZVU0VfVVNFX1ZFUlNJT04pLiAg
Tm90IGp1c3QgaGVhZGVyDQo+IGd1YXJkcy4NCg0KSSBkb24ndCB0aGluayB3ZSBuZWVkIHRoZSBo
ZWFkZXIgZ3VhcmRzLCBJIHRoaW5rIHRoZXNlIGFyZSBtb3JlIGZvciB0aGUNCmNhc2UgdGhlIEFQ
SSBjaGFuZ2VzLiBXaXRoIGp1c3QgYWRkaXRpb25zIHRoZXJlIGNhbm5vdCBicmVhayBhbnl0aGlu
Zz8NCg0KPiANCj4+IGp1c3QgcHVzaGVkIHRoZSB1bmZpbmlzaGVkIHBhdGNoIEkgbWFkZSBpbiBE
ZWNlbWJlci4gSXQgZ290IGNvbXBsaWNhdGVkDQo+PiBpbiB0aGUgaGlnaCBsZXZlbCBBUEkgYW5k
IEkgZGlkbid0IGhhdmUgdGltZSB0byBmaW5pc2ggaXQgeWV0Lg0KPiANCj4gWWVzLCB0aGF0IGRv
ZXMgbWFrZSBzZW5zZSBmb3Igc2V0dGluZyBkZWZhdWx0cyBiYXNlZCBvbiB0aGUgdmVyc2lvbiBv
Zg0KPiB0aGUgbGliZnVzZSBBUEkgdGhhdCB0aGUgZnVzZSBzZXJ2ZXIgZXhwZWN0cy4NCj4gDQo+
PiBodHRwczovL2dpdGh1Yi5jb20vbGliZnVzZS9saWJmdXNlL3B1bGwvMTM4Mi9jaGFuZ2VzLzI0
ODM2ZGVkMThlOTczNmViNDY5MTYwMDYwMGZmMWQ3Y2Y1ODFlMjkNCj4+DQo+PiBCYXNpY2FsbHkg
SSB3b3VsZCBsaWtlIHRvIGFkZCB0aGUgQVBJIHZlcnNpb24gdG8gdGhlIGZ1bmN0aW9ucywgaW4g
b3JkZXINCj4+IHRvIHNldCBkZWZhdWx0cyBmbGFncy4gVGhlIHRvcGljIGNhbWUgdXAgYWJvdXQg
RlVTRV9DQVBfQVVUT19JTlZBTF9EQVRBLA0KPj4gYmVjYXVzZSBpdCBjYW4gY2F1c2UgZGF0YSBj
b3JydXB0aW9uLCBidXQgdGhlcmUgaXMgYWxzbyBhIHJpc2sgdG8gY2F1c2UNCj4+IHJlZ3Jlc3Np
b25zLiBTbyB3b3VsZCBiZSBnb29kIHRvIHNldCB0aGF0IGJhc2VkIG9uIHRoZSBBUEkgdmVyc2lv
bg0KPj4gKGFzc3VtaW5nIHBlb3BsZSByZWFkIHRoZSByYXRoZXIgbmV3IGRvYy9DaGFuZ2VMb2ct
QVBJLnJzdCkuDQo+Pg0KPj4gQW55d2F5IHlvdXIgZnVuY3Rpb24gc2hvdWxkIGJhc2ljYWxseSBi
ZQ0KPj4NCj4+IGludCBmdXNlX3NlcnZpY2VfbWFpbl9yZWFsX3ZlcnNpb25lZChzdHJ1Y3QgZnVz
ZV9zZXJ2aWNlICpzZXJ2aWNlLA0KPj4gCQkJCSAgICAgaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSwN
Cj4+IAkJCQkgICAgIGNvbnN0IHN0cnVjdCBmdXNlX29wZXJhdGlvbnMgKm9wLA0KPj4gCQkJCSAg
ICAgc2l6ZV90IG9wX3NpemUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgaW50IHVzZXJfYXBpYWJpX3ZlcnNpb24sDQo+PiAJCQkJICAgICBzdHJ1Y3Qg
bGliZnVzZV92ZXJzaW9uICp2ZXJzaW9uLA0KPj4gCQkJCSAgICAgdm9pZCAqdXNlcl9kYXRhKTsN
Cj4+DQo+Pg0KPj4gSS5lLiBhZGRpbmcgaW4gJ3VzZXJfYXBpYWJpX3ZlcnNpb24nLiBBbHRob3Vn
aCB3aGlsZSBsb29raW5nIGludG8gdGhpcw0KPj4gYWdhaW4sIG1heWJlIHdlIHNob3VsZCBtaXMt
dXNlICdwYWRkaW5nJyBhbmQgcmVuYW1lIGl0ICdhcGkgdmVyc2lvbi4gSXQNCj4+IHdvdWxkIGRl
ZmluaXRlbHkgc2ltcGxpZnkgdGhpbmdzLg0KPj4NCj4+DQo+PiBXaGlsZSB5b3UgbG9vayBpbnRv
IGFsbCB0aGVzZSB0aGluZ3MsIHdoYXQgaXMgeW91ciBvcGluaW9uPyA7KQ0KPiANCj4gSSBsaWtl
IHRoZSBpZGVhIG9mIGVuY29kaW5nIHRoZSBGVVNFX1VTRV9WRVJTSU9OIGFzIHRoZSBwYWRkaW5n
IHZhbHVlLg0KPiBJIHdvbmRlciBpZiB0aGVyZSdzIGEgZGFuZ2VyIG9mIGEgY2xpZW50IHNldHRp
bmcgdGhlIGZpZWxkcyBtYW51YWxseToNCj4gDQo+IAlzdHJ1Y3QgbGliZnVzZV92ZXJzaW9uIHZl
cnNpb247DQo+IA0KPiAJdmVyc2lvbi5tYWpvciA9IEZVU0VfTUFKT1JfVkVSU0lPTjsNCj4gCXZl
cnNpb24ubWlub3IgPSBGVVNFX01JTk9SX1ZFUlNJT047DQo+IAl2ZXJzaW9uLmhvdGZpeCA9IEZV
U0VfSE9URklYX1ZFUlNJT047DQo+IA0KPiAJZnVzZV9tYWluX3JlYWxfdmVyc2lvbmVkKC4uLiwg
JnZlcnNpb24uLi4pOw0KPiANCj4gc3VjaCB0aGF0IHZlcnNpb24ucGFkZGluZyBpcyBub3cgc2V0
IHRvIHN0YWNrIGdhcmJhZ2U/ICBUaGUgd3JhcHBlcg0KPiBmdW5jdGlvbnMgaW4gZnVzZS5oIHVz
ZSBzdHJ1Y3QgaW5pdGlhbGl6YXRpb24gc28gdGhlIC5wYWRkaW5nIHZhbHVlIHdpbGwNCj4gYmUg
emVybywgYnV0IGZ1c2Vfc2Vzc2lvbl9uZXdfdmVyc2lvbmVkIGRvZXNuJ3QgYXBwZWFyIHRvIHJl
cXVpcmUgemVybywNCj4gd2hpY2ggbWFrZXMgc3VjaCBhIGNoYW5nZSBhIGJpdCByaXNreS4NCj4g
DQo+IERlYmlhbiBjb2Rlc2VhcmNoIHNlZW1zIHRvIHRoaW5rIHRoZXJlIGFyZW4ndCBhbnkgZGly
ZWN0IGNhbGxlcnMgb2YNCj4gZnVzZV9zZXNzaW9uX25ld192ZXJzaW9uZWQgb3IgZnVzZV9tYWlu
X3JlYWxfdmVyc2lvbmVkIG91dHNpZGUgb2YgZnVzZSwNCj4gc28gdGhpcyBtaWdodCBub3QgYmUg
YSBiaWcgcmlzay4NCj4gDQo+IElmIHRoZSByaXNrIGlzIGFjY2VwdGFibGUsIGl0IHdvdWxkIHJl
ZHVjZSB0aGUgYW1vdW50IG9mIGNvZGUgY2hhbmdlcyB0bw0KPiBhZGQgdGhlIEZVU0VfVVNFX1ZF
UlNJT04gbnVtYmVyIGFuZCBmb3JjZSBwcm9ncmFtcyB0byAjZGVmaW5lIGl0IGJlZm9yZQ0KPiAj
aW5jbHVkZSdpbmcgZnVzZS5oLg0KPiANCj4gVGhlIGV4aXN0aW5nIGZ1bmN0aW9ucyB0aGF0IHRh
a2UgYSBzdHJ1Y3QgbGliZnVzZV92ZXJzaW9uIGNvdWxkIGp1c3QNCj4gaWdub3JlIHZhbHVlcyBs
aWtlIDAgb3IgdmFsdWVzIHRoYXQgYXJlbnQndCBpbiB0aGUgcmFuZ2UgMzAtMzkgb3INCj4gMzEw
LTMxOS4gIFRoYXQgbWlnaHQgYmUgZW5vdWdoIHRvIGF2b2lkIGNvbXBsYWludHMuDQoNCkhtbSB5
ZWFoLCB0aGVyZSBhIGJpdCByaXNrIHBlb3BsZSBwZW9wbGUgd2hvIGFjY2VzcyB0aGVzZSBmdW5j
dGlvbnMgd2l0aA0KZGxvcGVuLiBNeSBwZXJzb25hbCBvcGluaW9uIGlzIHRoYXQgb25lIHNob3Vs
ZCBub3QgZGlyZWN0bHkgYWNjZXNzDQpsaWJmdXNlIGZ1bmN0aW9ucywgYnV0IHdyaXRlIGEgd3Jh
cHBlciBsaWIsIGNvcnJlY3RseSBkZWZpbmUgdGhlIEFQSQ0KdmVyc2lvbiBpbiB0aGF0IGxpYiBh
bmQgdGhlbiBkbG9wZW4gdGhlIHdyYXBwZXIgbGliLg0KSSBuZWVkIHRvIHRoaW5rIGFib3V0IGl0
IGFnYWluLCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0IQ0KDQpDaGVlcnMsDQpCZXJuZA0K
