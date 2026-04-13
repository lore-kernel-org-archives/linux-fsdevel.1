Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370403AEF53
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083822; cv=fail; b=orduqNvQcAPPS8BbSDIP4utzfCp1A/NuQwjmDQpr8amScYW28Swc23Bf/fNRvs6j1AGuysr74+GO3shf8rwaWCH2ecQjwANxW/ZXh72qX75G8wUqduQmXJqhrkD/yaJevQZLB4fwEADjLUqqH2OM6JZmQoWFv6igYG5+INnBHm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083822; c=relaxed/simple;
	bh=k94R0GLePkHBkg/Xez5y4G7y8QTgKATVqZHGsUXFsw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XW85GYq6XmD0j1KSesMGnG8GYOYuHLlOlfaw308WJAjhUqQ3EgYgvSfakZBz8jhKLHfJlGv81CrUgA4T64j7n2TMkcq1qvUgzxo9osJqXKyjrLduzdmgHBYKaA5i+n2r0Qn/r8fUUIGFrxZe2nyMKInOgyUXWhAid5tjt+EgxCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=1J2BTOzl; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="1J2BTOzl"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021102.outbound.protection.outlook.com [52.101.57.102]) by mx-outbound15-10.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Apr 2026 12:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdB7dNZqyTiu5vSpEfnXmruK0TAQ/X/T2g03RANa+H3ukMTCYLOEm3aUvDFQqaBbrJB4GVVOdEybQ2/u9vyPIOwbCSFQoW4JRARD82cqb5xxD6ujIKYbDp6KmpN6ztOw0wktnQtJh6pr98f4IKMYeZ+ZaggO80scebH7tgtvJgdsbkp0VJcjl7aK0BS2vC6EWQ+AhrwqgFL+phPfQ2SQoMmHLDKh+gRGGePyxa7Vlp0R6sH9AGnXqpGumyjQg4nT9kn+wi1r12/g8GV/T8Tdaq4EGhh+ZKXCSu/fMhnIbDcbho0FUlAhE1KKyw2ll1nYT/z5pVfchDDT+UGmwJXKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k94R0GLePkHBkg/Xez5y4G7y8QTgKATVqZHGsUXFsw4=;
 b=Bj/CL+ITEQp6alw1UsfcWKlBVxXtDm30OorMbC6ebnCB6VhwRFKLI941jD6fusM8scuP2w7JYNZOfVEftLNanob1G7eMrbjobDV3gD2PZuVW8Kxwx8VLV5nIj15gZF/TXS7CaJDMs/F9d/uwIp7TuiJx/NQS0ysoXFMgnQehqSfADLbbg4hovv/4WCuUl/wmwUUrt/T+Vxzg0na4MfenKIJDeQGFy2A5uAWbCgzQ3hbJM604syMgaRNyXEq2a3EFCjQ+gmC47WJPsM6uEKeXvwqOs8NNTtdYURtte+2xHTJT72vpUlszi51MVPs4LS+ufIp/Z34ijQ9YOoG3Aq9RPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k94R0GLePkHBkg/Xez5y4G7y8QTgKATVqZHGsUXFsw4=;
 b=1J2BTOzlwB4Ffx3DgNIFrJJ4y7uEvhU1CZLvWZ7BzKKyvkyGY/nfuzpHfneI1b2DTZ2SzGsmqgGgRbniWZKxy61AdleyyIMVbWpSUr3FOf6wx1LWbszLwNKDFo5vN7/ZtZ6WnpjYfxATtJBHjDanpQmjvMXE5/LjdjRJzifcnfg=
Received: from DM6PR19MB3865.namprd19.prod.outlook.com (2603:10b6:5:1::20) by
 SA0PR19MB4539.namprd19.prod.outlook.com (2603:10b6:806:bb::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Mon, 13 Apr 2026 12:36:38 +0000
Received: from DM6PR19MB3865.namprd19.prod.outlook.com
 ([fe80::24ba:1646:4006:4a9f]) by DM6PR19MB3865.namprd19.prod.outlook.com
 ([fe80::24ba:1646:4006:4a9f%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 12:36:37 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>
CC: Bernd Schubert <bernd@bsbernd.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Joanne
 Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Subject: Re: fuse-devel list on kernel.org
Thread-Topic: fuse-devel list on kernel.org
Thread-Index:
 AQHcxoauUvag1NOrKE+PfXajoV3OBrXThiGAgAABO4CAAF3bAIAAEjUAgADdDACACB8WAIAAA7oA
Date: Mon, 13 Apr 2026 12:36:37 +0000
Message-ID: <5b67c52e-932c-4b86-821b-6ea48af5ba17@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480>
 <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
 <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
 <5d7295b0-bd7e-41e7-b176-3d19b240413c@bsbernd.com>
 <20260407191046.GL6254@frogsfrogsfrogs>
 <CAOQ4uxiU3RcoNMD21Yx_ZPqCpmtL8-Eda=a5+uJC+AsO7F=_2Q@mail.gmail.com>
 <CAOQ4uxg+DhWoKtHFOt4eEgYYqAAmcJG_q3nJcQ2ZVOFCWRN0bw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxg+DhWoKtHFOt4eEgYYqAAmcJG_q3nJcQ2ZVOFCWRN0bw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3865:EE_|SA0PR19MB4539:EE_
x-ms-office365-filtering-correlation-id: 421140d5-a5f4-427d-b217-08de99594e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|10070799003|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 fdurFQ1T3WGB8fGSD6k2ZDftOU2QwBF9xAFcMnKYRg6W3OU3/um+OnqXBss9cvxlrxYJI7klT/GedI1I44HF9pGH7+Lw4fmvfFl8GkPKBKYwLB5jAN6155cOC6pZZ4xtMvdDwMavYjYvpFHfeLn3c7Cg9oQsWHQffKbQT0fbUaWjmMuWspXkq5gIbH+lza0xgIrKLZAoBjy/eKIgULH1P/2bIj6HhgFM8eU/Cfx7dObOpYk2+3/+0bUEdk+nyKiwO5SyI2MdeN7Rk+K0fKw/17erErKINaH9cxEMdPyRKPyEFdTS6IwNVL7RkEEzrdUqejlgsOj/5frnHVVjFETI3Aw53/4PruEl/XmfahsZZzH4T9+fgxx1v9yG6TWAYcPbgMdREX/4unkX21jkTLpNOOt6bGyP83w9NaLo2owiBqsHteJKaaMOxO7j5Y29d3EKkf6S9Xrm6opLxKNiYfFw0pEhdkxgTtDmnAX/ofCN4GTXwDjOs1cWmLEc+L6wkkEeRPiwfIbeqzp7pWIgNFF8uWyW6z+7upnDD+HBbDCxwnBYFo12sfXSCG+eaK0SY4MFZKBeqRv7hbUdwH/9d5M/J2y52JK/tTq+jH2tzZcszqF7FB3XbYHBBeoFOact64NoAvHOmh93kyfW8Jyxz2TbnylEDt+Y2uXOFJt8hNUBobdWJpqe7dpoyqsU3/frLUkdlJo66ntEqT2KDOFg4LcGvIxgfdQiqe6YSn5ionomsrAaLjAhUksY9tv6JnAsQRkJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB3865.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1BhcWtUVm5ZMjA4YjBnT05LdCtxZFUvQzN4bE5wdlhSSHJsWXNNK3pybkpE?=
 =?utf-8?B?TThlb29wOS9oc2xoN0RxSWxLM0RpMXpzTTI0bGdoSjQ4RzdxakFFbC9lS1N3?=
 =?utf-8?B?ZzI5dDhZTkE4Wi9Bb2ZNWW9VNE1rc3M3dFlkb09pU0dJWWk2eGNVK2JXRUdL?=
 =?utf-8?B?MnU3dEIwOGpRNks2WUdkUm04QXRvUEtnZWNxakh1Ujh6NWxkZmJhenAxZmI5?=
 =?utf-8?B?Yk9LZWZFRWdpaXMyVS9VUU5URTZkSDlkcEZVU1IwYVFUVFg2S2lBSE5nU2NG?=
 =?utf-8?B?RU1qVWlMUWFpeU5kUWZ4MlF2TlhlTFdXVXBINVNPVXJwVVl4MVA3MjN2Y0xM?=
 =?utf-8?B?YU11UFRkZjZva2JLZms4MGhtU0VhRXBwSGViMzVUa2VYQkFMWUpQMW1hMGI0?=
 =?utf-8?B?MW9lcVhaSHFpK3FwNkxEbURPM1JMWWphaG1EbkcrTVZIY25XN3A2VDFYUWNM?=
 =?utf-8?B?cld3b2s5N1FuZnM4UTR2NjYwUGpZUE1XeVZMMndydVg4LzliSDZQT2tRMWtx?=
 =?utf-8?B?RS9GZXhINXhOTGlWQmp0NDhoazB3M2tBVGozUGpNcWhlVnFBaEtwSDcvOEl6?=
 =?utf-8?B?VUNKTFQvL0I3MVBOOG56Ky8wK29VblFqM1paTnJZeGZDZGVKZXpmYnIzTGFM?=
 =?utf-8?B?d2pvMTJFRDRDaldROUFmbExSenhGSWQvNThLaVVnSU9TbmE2eVp1MjFXb2tl?=
 =?utf-8?B?em1hVnlKTUM2QWhudzN6OHZaRTNwSUNNeng4ZmJmRjJwdkRzV0lxMEpOUEtE?=
 =?utf-8?B?OHpZcVVEa090cEExWmhZNTdzamNBUEJKNFZrMUk5Q05NY2dkck91VkNwdEs3?=
 =?utf-8?B?VUM2c1lSNG9Wbmo4aU9hWHk1ZFJxUTJOUTJKMjlpOUREUHZxNGVTK3FvQ0Rw?=
 =?utf-8?B?SGtEYkJOMFhWUHJyYkd4Vk9xdDA1MWVhdmJXbXVzbVJRdFZFWnJ3R05COEh0?=
 =?utf-8?B?NGoxeit5eWR1T2xXdFVGVnhVcFBVQ0JRaDkzcExTMHBTSWFMT3pZT3pMWGd6?=
 =?utf-8?B?cFJmY0xpWURUeWV1QzhNMEpEWkQ2TlNvNlRGS2FEQkFmWDBrUnBVSzRhWnJi?=
 =?utf-8?B?Q1U4THdVNmZRdzVzOGtnNmtjQzNMWFdxV2E0OUZOK25CaHZGSzkvSk9zOU4v?=
 =?utf-8?B?QnNLZWxBS2JVY0ZaRmp2R2lDQ2Eva3lmQWo1V05CRWQxOUxjVGduMWdmdUtK?=
 =?utf-8?B?WmswR2FCNThwMUhmY2JlaEIvRTRsVm16eTV5STZ0UzVoQTlMTGh0cnpvUjVU?=
 =?utf-8?B?ZHVBaXBmTkZiVDFIemJUS3RjaTlROVV6MHBmZThIRkthb1RiYVkwek9IMVVu?=
 =?utf-8?B?TG1LdjNWWFIvcW5RV0dDL0VGeUxFTjVJcXd1MVJnZHA4Yytab2JCMzRtdHEz?=
 =?utf-8?B?SjNPMDNPY0F1YUtXcC85WGJWKzdDYnZkRExlMTJYenY1STJjYkowYll0R21R?=
 =?utf-8?B?eWNpNVhjdlNMRFE5NGFEamRlWm5HMkswS1g1NTFySlhndlVDbG0yR0lZTzlM?=
 =?utf-8?B?aTFRRUN1aVc0WE40QWMwenZCK3BqdnBXSzZ5dGhzM1FjYXBRUWJ6ZFVQL3Jy?=
 =?utf-8?B?cjhaMDZDNTc1NlVyeURUMWdISWlIcnZSNXhrelhQM1hXL0RTVmoySklRYVI0?=
 =?utf-8?B?RnNLelNVUFNnbWMzcXN1amZzWGljMjI5NjJlWVNJQTFnQ3JwR1lsVmlHbmhu?=
 =?utf-8?B?bWJqeFZDTHUwSU9rVlpFOVpsNlB5MUJCZDA3T0xwVVlxaW9LNjlMT0dNZCtr?=
 =?utf-8?B?NFB5RkVXN3BLZGZhN29pZ3h0MGFJN0lKWlhxUStlUGhsdzg4UG14M1pHUlBG?=
 =?utf-8?B?K0pZODBPWEQyRkNyR092UnJpMklyak1GMDRPV0NhUDNwdEVrd0U3NWloWHRw?=
 =?utf-8?B?cS9OMDNLNmhRRGc4ODZKRzFycHhWK3k0a3Y5dlFodEIwaTk1OVpKcVBhY1N4?=
 =?utf-8?B?Nnh1MDVmQjlNL05sR1lqeUxQM243ZHdJUWlIbXhGT3ExTE4rejBsUlUyenZV?=
 =?utf-8?B?Sk04YjZrZ1FCMjRmenhGVWxxanJnTkJsMHoxdUpOYXJpUGRGUW1vdDlTbG9Y?=
 =?utf-8?B?WFVQMVRQNENFQVpkcnNmbVVya3dFeE53RUc5OWhQTURMRmhUSmw1ZW9lZlZa?=
 =?utf-8?B?ekdObkF2bWtyWklxSS9sdHdtdGgrN1E2TDZudXRCZ3RhanljU2NJNXVqdXBl?=
 =?utf-8?B?VXV4NUc1OXVUcWFWbkxNR2NVYzN2UTR4eHZOc01lOHpEQnR0b25XR2tYYnph?=
 =?utf-8?B?SkFKRnFqZG9UWXJjM3k0TGZFQUlEdDNGZkxIOGNNWTk2MDZvaUwwNWJxNS9T?=
 =?utf-8?B?WU9WbDhIVGtieG00SkE3dFNFOWFISmdNWkdaZ3RNVWFMV2gySklFMWtIM2ht?=
 =?utf-8?Q?9vgmlxUq1zMY0unTsZo55ho3dAovxsDg3ggMU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AACE28B106BDB443BEAC635ED0B7EE9E@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qoCVSuJSfAB3DAngi3WnxPbSHhNAHiGD1KSOzAXh7CNsofcmSubD6/8A9WcM4xG8+ljHyX2nr+ZidWYYRofwuTJOwTVmoIn+oZHviVDOhNccjHRMEeX0F7KbiBAIPrTE0xF0+9IdihVIpqpC94GRn/yqGCIsAytfdsOpi9vhi01JykC/bpUmlnVQCpSWcm9ix3I5Jz3fTaBPCZ11AxdeoT3SwTB235zI1EIfTDQ0sWVl6dIlIVIMYC/TPddfu8oM/SH3aLuxK8M7ncPykJpiTtMCBzHNV/XY1JS3zxKeHKmlHGYpBlvJYkdKD/p1sWIqzElHz3o8Y3PTQfJRJ2OZhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6s1Z/pAn2oyO7EdA9uIx37R7PwQGQHoJD7Zdtmvm3gTNqOinSdwcp/zJvrNZ4ZPNW7+uE90NNYQfRWLNmp4vgUpourUzOOmR5YykXkh5E7yIcS29B6JvtEVsULDdbFj5pjVtx78w3liwFBK33c4TCitYaO2vGX9a7p5n4Xndvh5tfDXtU4FhVwh7GEga9fHUh/CvmeUu1BGg1tZNhnANMlJdajqDkyFonDgNMPaOiusg+bSwk6sDxeDjZ1fNe7RO7R0wE20gMk9nJGkoA5TYVOjQVBk3u8ipWHjTjfb6qnlQE3/Brnf0WtNpRrwuuDhxf4zY2gfhyOeSi7lzvT7/mFvcibv8iq92oDnzhW34hC0vUUvXfdmPQU7NblIBDnaO64QhdlGVDZPmC/BrJ4M1GyNNqUJGIFWaHNSGx/R+amcwo1Od4AsK62j/GohKk26kWfOGQlXRt4u2Jrs4ooQKHnWEjGJ4IVLf8oQhTJehaeoFPmZdk1JrBoPWlB64MCt5b55TJ9baUs66jPZp24jyMSEH1Mc/qMp/QQx7oAo2lZn3mQP9l13zqQVyD3ewGBTeNIqr8Sv0KMVNAqy2y94ElMi+g6UBgYuwcFz4GL4qUczmPMhlVTTGmzzhB9UiyxPkumhi6cJEBRDlPcZwWJ3oeg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3865.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421140d5-a5f4-427d-b217-08de99594e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 12:36:37.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNyhRFg0yj43SB+I/SGHZTbuQIL9hMRzb/9ngYw/U8YZjsaUG7bao634UGO3IgTZbLPlqUFJOhRMUV/uFyey0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4539
X-BESS-ID: 1776083800-103850-7696-2434-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 52.101.57.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGZkZAVgZQ0CzNJMnCwiTFzN
	TSMDkt1czMJM0IyDMzNk62sATKKNXGAgDlpsYWQQAAAA==
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272516 [from 
	cloudscan19-77.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNC8xMy8yNiAxNDoyMywgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+IE9uIFdlZCwgQXByIDgs
IDIwMjYgYXQgMTA6MjHigK9BTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPiB3
cm90ZToNCj4+DQo+PiBPbiBUdWUsIEFwciA3LCAyMDI2IGF0IDk6MTDigK9QTSBEYXJyaWNrIEou
IFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pg0KPj4+IE9uIFR1ZSwgQXByIDA3
LCAyMDI2IGF0IDA4OjA1OjM2UE0gKzAyMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPj4+Pg0K
Pj4+Pg0KPj4+PiBPbiA0LzcvMjYgMTQ6MjksIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPj4+Pj4g
T24gVHVlLCBBcHIgNywgMjAyNiBhdCAyOjI14oCvUE0gQmVybmQgU2NodWJlcnQgPGJlcm5kQGJz
YmVybmQuY29tPiB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBPbiA0Lzcv
MjYgMTQ6MDQsIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0KPj4+Pj4+PiBPbiBUaHUsIE1hciAyNiwg
MjAyNiBhdCAxMDozNDozM1BNICswMTAwLCBCZXJuZCBTY2h1YmVydCB3cm90ZToNCj4+Pj4+Pj4+
IEknbSB0YWtpbmcgRGFycmlja3MgZXhhbXBsZSBoZXJlIGFuZCBwb3N0aW5nIEFQSSBjaGFuZ2lu
ZyBsaWJmdXNlDQo+Pj4+Pj4+PiBjaGFuZ2VzIHRvIGxpbnV4LWZzZGV2ZWwuIFdlIHNob3VsZCBj
b25zaWRlciB0byBjcmVhdGUgYSBmdXNlDQo+Pj4+Pj4+PiBzcGVjaWZpYyBsaXN0IGlmIHRoYXQg
aXMgdG9vIG11Y2guIFRoZSBleGlzdGluZw0KPj4+Pj4+Pj4gZnVzZS1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQgaXMgcmF0aGVyIGhvcGVsZXNzIGR1ZSB0byBsYWNrDQo+Pj4+Pj4+PiBvZiBz
cGFtIGZpbHRlcmluZy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IExldCdzIGRvIHRoaXMg
YWxyZWFkeSENCj4+Pj4+Pj4NCj4+Pj4+Pj4gaHR0cHM6Ly9rb3JnLmRvY3Mua2VybmVsLm9yZy9s
b3JlLWFyY2hpdmVzLmh0bWwNCj4+Pj4+Pj4NCj4+Pj4+Pj4gRG8geW91IHdhbnQgbWUgdG8gc2Vu
ZCB0aGUgZW1haWwgdG8ga2VybmVsLm9yZz8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSBzdWdnZXN0IHRo
YXQgd2UgYXNrIGZvciBmdXNlLWRldmVAbGlzdHMubGludXguZGV2DQo+Pj4+Pg0KPj4+Pj4gSnVz
dCBkb24ndCBjb3B5IHBhc3RlIG15IGZ1c2UtZGV2ZSB0eXBvIGluIHRoZSByZXF1ZXN0IDspDQo+
Pj4+Pg0KPj4+Pj4+PiBhbmQgdGhlbiB3ZSBjYW4gbWlncmF0ZWQgdGhlIG9sZCBzb3VyY2Vmb3Jn
ZSBhcmNoaXZlcw0KPj4+Pj4+DQo+Pj4+Pj4gSSdtIGFsbCBmb3IgYSBuZXcgZnVzZSBtYWlsaW5n
IGxpc3QuDQo+Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gQXMgZmFyIGFzIEkgY2FuIHVuZGVyc3Rh
bmQgZ2V0dGluZyB0aGUgYXJjaGl2ZXMgZnJvbSBzb3VyY2Vmb3JnZQ0KPj4+Pj4+PiByZXF1aXJl
ZCB0aGUgYWRtaW4gcGFzc3dvcmQ6DQo+Pj4+Pj4+DQo+Pj4+Pj4+IGh0dHBzOi8vc291cmNlZm9y
Z2UubmV0L3AvZm9yZ2UvZG9jdW1lbnRhdGlvbi9NYWlsaW5nJTIwTGlzdCUyMEFyY2hpdmVzLw0K
Pj4+Pj4+Pg0KPj4+Pj4+PiBNaWtvcywNCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2lsbCB5b3UgYmUgYWJs
ZSB0byBoYW5kbGUgdGhlIGFyY2hpdmUgbWlncmF0aW9uPw0KPj4+Pj4+DQo+Pj4+Pj4gSGF2ZSB0
aGF0IHBhc3N3b3JkIGZyb20gTmlrb2xhdXMuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBFeGNlbGxl
bnQsIHNvIHdpbGwgeW91IGJlIHNlbmRpbmcgdGhhdCBlbWFpbCB0byBoZWxwZGVza0BrZXJuZWwu
b3JnPw0KPj4+Pg0KPj4+PiBJIGNhbiBsb2dpbiBoZXJlIGFzIGFkbWluOg0KPj4+PiBodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9hZG1pbi9mdXNlLWRldmVsIHdpdGggdGhlIGFk
bWluDQo+Pj4+IHBhc3N3b3JkLg0KPj4+Pg0KPj4+PiBIZXJlIGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L21ib3gvZnVzZS1kZXZlbCB3aGljaCBpcyBzdXBwb3NlZCB0bw0KPj4+PiBjcmVh
dGUgdGhlIG1ib3ggZmlsZSBpdCBhc2tzIGZvciAidXNlciIgYW5kIHBhc3N3b3JkLiBBc3N1bWlu
ZyB0aGUNCj4+Pj4gcGFzc3dvcmQgaXMgdGhlIHNhbWUsIHdoYXQgaXMgdGhlICJ1c2VyIj8gQWxz
byB0cmllZCBteSB1c2VyIHNvdXJjZWZvcmdlDQo+Pj4+IGNyZWRlbnRpYWxzLCBkb2VzIG5vdCB3
b3JrIGVpdGhlci4NCj4+Pj4NCj4+Pj4gQ2FuIHdlIGRlZmVyIHRoaXMgYSBiaXQ/IFRvbyBtYW55
IHRoaW5ncyB0byBkbyBhbmQgSSB0aGluayBmb3Igbm93DQo+Pj4+IHJldmlld2luZyBKb2FubmVz
IFBhdGNoZXMgYW5kIGZpbmlzaGluZyBzeW5jLWluaXQgYW5kIERhcnJpY2tzIG1haWwgaGFzDQo+
Pj4+IGEgaGlnaGVyIHByaW9yaXR5IHRoYW4gZmlnaHRpbmcgd2l0aCBzb3VyY2Vmb3JnZSBtYm94
Lg0KPj4+DQo+Pj4gSSBkb24ndCBoYXZlIGEgcHJvYmxlbSB3aXRoIGRlZmVycmluZywgYnV0IEZZ
SSB5b3UgZG9uJ3QgaGF2ZSB0byBoYXZlDQo+Pj4gb2xkIE1MIGhpc3RvcnkgcmVhZHkgdG8gZ28g
d2hlbiB5b3UgYXBwbHkgZm9yIGEgbmV3IGxpc3QuICBJdCwgZXJtLCB0b29rDQo+Pj4gdXMgbW9u
dGhzIHRvIHNjcm91bmdlIHRoZSBlbnRpcmUgeGZzIGhpc3RvcnkgdG9nZXRoZXIgYWZ0ZXIgbGlu
dXgteGZzDQo+Pj4gd2FzIGNyZWF0ZWQuDQo+Pg0KPj4gSSByZXF1ZXN0ZWQgdGhlIGxpc3Q6DQo+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsL0NBT1E0dXhqUmdRR3hXWVdi
UmJqVlp5MTlvQTVxS1pTZDllQU5LeUQ4eUNvQk5HUE5Od0BtYWlsLmdtYWlsLmNvbS8NCj4+DQo+
PiBJIGNhbm5vdCBpbWFnaW5lIGFueW9uZSBtaXNzaW5nIHRoZSBmdXNlIHBhdGNoZXMgb24gZnNk
ZXZlbA0KPj4gaWYgcGVvcGxlIGp1c3Qgc3RhcnRlZCBwb3N0aW5nIHRoZWlyIGtlcm5lbCBhbmQg
bGliZnVzZSBwYXRjaGVzIHRvIGZ1c2UtZGV2ZWwuDQo+Pg0KPj4gU2hvdWxkIGhhdmUgZG9uZSB0
aGlzIHR3byB5ZWFycyBhZ28gd2hlbiBpdCB3YXMgYWxzbyBwcm9wb3NlZC4NCj4+DQo+IA0KPiBX
ZWxsIHRoZSBsaXN0IGlzIHVwIChub3cgaW4gQ0MpIDxmdXNlLWRldmVsQGxpc3RzLmxpbnV4LmRl
dj4gYW5kDQo+IGFyY2hpdmVkIG9uIGxvcmUua2VybmVsLm9yZy4NCj4gDQo+IE5vdyB5b3UnYWxs
IG9ubHkgbmVlZCB0byBzdWJzY3JpYmUgYW5kIHNlbmQgdGhlIHBhdGNoZXMgdGhlcmUuDQoNClRo
YW5rcyBzbyBtdWNoIEFtaXIgZm9yIHNldHRpbmcgdGhpcyB1cCENCg0KDQpCZXN0LA0KQmVybmQN
Cg==
