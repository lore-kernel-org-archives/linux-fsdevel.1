Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795028114;
	b=Rcxsj17M2vdQ11G18b5DQHT6giQ0LKrfOvLs+P4OlAUq5vHvJrtapmdQS668+eZjZnGk
	 mwE/pdopw1iC2WOJmws/V7SS8auQwrM+PO5meXsysIIU6sO60Q7PSWgdgmPHydkb5ipOO
	 Ldhq/En+b+gQR6orQCvdnAJ8Rqei7I3WY3uPsOYZcOU+VPKwfrJITcR+nPHmqlrU9r69z
	 0aj9Za3OaUkORhsM21pMwain8gPEw9MjYF6ezcDLjjVkMO0thOkvfxk6YaTQG0g+e4228
	 rPMSvpjKCb+5X/b8HG65qmPuSTECoXR5kxF8VEicsfOIzQtJ6cwrcAG7/ag0DuanB0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028114;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=u/OlO/U0TrOxh6q4fgko3AV6OX+52kEBE1dkovbVVFg=;
	b=pNPgXCTh6pT018awLEj/M9eecBK30QZig19GwdCwmu2LVFZw9qLNzHferha7VTvrrWyV
	 SVDuypEne9lJOsq9pO2N/dqzBJDIZTE3U7/lJIjpShcgq7F6y546rPtyDzrYf8OND/io3
	 qxwbGUojo11fN5K9NmxPQP3qcE5SwdNX0u6CUdqA5j1uHqdrXk7uM9UpRmZ0dN48++e4o
	 c5ytda2Y1UceBCqNeV2YEYbq0MTmQ6VA9Q1VltrWqZerp1b+InkP+s0FkxeaFmToa8d5U
	 IOAZKmfkhKfH4K0hQ7Y0ZwFBU0lg776SJ4WWHQ7TW0ZSh62/w9gBzFypZiBXLGCtB2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wrfqOtDr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.21
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592A606A32C;
	Wed, 18 Nov 2026 18:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9592A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wrfqOtDr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPo4hyRwKMMxvO1dB5vNyoVV9PPBLhPMFKyDxlwN1KFoe4yJGp2LVvTG8Hh2pjUxWzl5s5Z3SnpMj6aTJDD3aMOPosZrMJonv1pvKJcduLLlVHJFC44Gn4mlM/lZHaGm+RjCaaA2DDOqwFQ1/UMKrszXYqh4PHy8wATu49ut6ZxKzAeoP7au3Qi9fdqs9u35JH00hBJ9lTexARysT0BO5kUcMwlt5nWhr/IPt+z5wWCuiLhhoCIYL9Jv/O9P/ew1dZUWoMNsqmqjJy/StCA1YEjkarWu3tcrg11s/+IoKPn6edeiA9GF8igfXq2hGk3tzTv5Uy44NQq4wH2pKsX22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/OlO/U0TrOxh6q4fgko3AV6OX+52kEBE1dkovbVVFg=;
 b=QiyWFWBMAeD/NkGRBTynG0sZupMkIyxDb7w2H4KYEAnC7JrJOESHUMbPPpKf9ytlNNWojhawP+FfVh4RmGGXzuvUz73WOJURCyoTiOXxkK60kEV87nEeKdWTMYg6OUFk40NAZphnkIYqgRb/v3IaHZY1eV+DzpMIQF2MkWSLF4gHur+kawmd/nBu498OLxv+oF66P18P3dTTENvFCzI4F0k4EAs2qepvtmDRsFPlkuEhzq2qn9zeVOmQ2Qik+X8j+Wu5MwO7wPrKiNDxNVT7tuqRLx1FWoZ4d/m1l6y8Gjl0X3dm8HDXK1W45zPwsQCs3+6cYUKRtYbOa7I3aWcd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/OlO/U0TrOxh6q4fgko3AV6OX+52kEBE1dkovbVVFg=;
 b=wrfqOtDrPposjRxXbzCEjJgmEDe83f78SDLC8qPNtElY3tnFIIzxfCPOR4+crKRRHnH7Bf1KoYk97rcM5E6bQTdAyibMcdPf7MwsVxxjzJxG+9B6Xxz9TLCcCvDc9CLFQ4AN2SUVFpjUxA5R+Bb+5O/WcPhuJt5/sHpgVW5usIE=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:55:02 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:55:02 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pfalcato@suse.de" <pfalcato@suse.de>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chrisl@kernel.org" <chrisl@kernel.org>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "youngjun.park@lge.com" <youngjun.park@lge.com>,
	"jack@suse.cz" <jack@suse.cz>, "minchan@kernel.org" <minchan@kernel.org>,
	"liam@infradead.org" <liam@infradead.org>, "baohua@kernel.org"
	<baohua@kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"jannh@google.com" <jannh@google.com>, "ljs@kernel.org" <ljs@kernel.org>,
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH mm-new v2 0/5] mm: remove unused functions
Thread-Topic: [PATCH mm-new v2 0/5] mm: remove unused functions
Thread-Index: AQHddmOplX4Ual33c0WC3Ng11Rrv27c0EUIAgAAClwCAABv+gA==
Date: Wed, 18 Nov 2026 18:55:02 +0000
Message-ID: <c28c2ab82afa2cb3f331f1f3b3b20159bc7767b1.camel@amd.com>
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
	 <f3219880-c944-473e-82cc-bd6b4196badf@arm.com>
	 <27ef4d8f-f4fa-49aa-b166-8335ca6f5898@arm.com>
In-Reply-To: <27ef4d8f-f4fa-49aa-b166-8335ca6f5898@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|SA3PR12MB8801:EE_
x-ms-office365-filtering-correlation-id: 1ef21bad-80d8-4b62-fb87-08df45a573da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|921020|38070700021|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
x-microsoft-antispam-message-info:
 obugRtRmiy5WySdB3xbX9CAzGuA7uI1l1jueIB2TUSD3yHo7flihmmWwf4u5JtMUAtmvVMbY30Yf8Fczayu5Sy41LlPa1yFp1taSmHh2XEQDhTjQ//zrEo0Zevh9YUI8WsuYuSQ71ZGojM6kApQalOGlYlkJHTWRkDoqiVJqwtGOTeG2NB53QE5dqy6VGwRw5PwHoctS0hjY7AAILAdJetHCLxDPVU/v9NAHRZGgdIjh76Bn/yQsL1+G+b9/QIzHeCaE+/ncXlv75NqKgbD17lLyWXjsOw4tafvPohg1dG1YSOt27oLRq4ROgSC7If3zuMOFbQWx+yXkzzT2sWMTACJ60KZXQT3+UGAhrfzyv+mWgaMQHG2cf1LHN2GP/yAOfm8+ZqnHjLI7oIqIQL3tIxDsMXFS8xuQJax1kCJhSpamRGwlyrnvxllnG+og8Gdmu97b6Q2RQtFCUl8a3Uy5pZuk2jfRtZvJe7z78faKG7rsfJlSSBqgIMhlTYtAkC2Y4e7AjYBspB258/FQaScfyxUuKFoYfdr+R0PatN94GKWZdsjgoS47WNAGs3iZ6oTL2zQugYwxqIAU3d/T2lbyt9Txr2zzDuMtjn1R0eExdm5zWilCcWqaWMO+RrfYsrclpMuyCFY3DhttinJ2sDVxUqFXaZaxZ242xXJJpWOhgkuLSS8WRk7rDLCFlNkuPmau
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(921020)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RU1oZk9xVGhiR0hPKzhLcXJrU0Z1OUs1WmFCb3VCWS92MGltR0lqbzVnTWJJ?=
 =?utf-8?B?cWdrSkF4d2dTamxMbnYzcEFHRHVLd2ZHcGkyRHdqNjFwaEFOc21LOUlSeENF?=
 =?utf-8?B?OXRiaURjUlA1bEVNek5DbVpLQVQ2dVRmdExub0IrRFZKUTJ1dG96ZDV0NHNL?=
 =?utf-8?B?WDNiLzhjbU9SQmhVbmtPZC9pbitDRUdla0g1M280MW5FNVRsWUJPVFloUzBh?=
 =?utf-8?B?eURBeStqZU5nV0V4eCtMSUMxMlE4a2I0emE2ZWdCUmdlVU1qaEJocVFqeUVZ?=
 =?utf-8?B?WGNEVUtqUCtsenZBSHdIdVZ2aFpkdGZkU09yYUgwb2FLR1ZPdUZZTUJzMHBR?=
 =?utf-8?B?VkxheGxXRVdLRnMyU3NBUmNXanc5cHJMWnZVbjk0cFdRV0tIOU1aSWNMdnJ1?=
 =?utf-8?B?T1dqYTFQcXJxVmFWR2lyLy8xd0lvNENxQUs5T05MdjgxTHlNREF1WkRESk1K?=
 =?utf-8?B?dkFuTVNpd1c5a2tyckwzZERNdnQ5OFpNeFU0UTZMN0dCR3RBOU1hT3lRajk5?=
 =?utf-8?B?dEc0dUlTbnBBSS9wR2pSc0pwU2ZYUWxlYk5yTXpXaHQ3RnVZQVNpOTA0ZGVF?=
 =?utf-8?B?alM1QWpBdkJmWUNocERscnJxVW41cWNFMkRVemhWaGtrUk51SjUvWGcrdzFS?=
 =?utf-8?B?bnhGREZLRmhVL2R2bXpBQXpleVBOTCt6emtsU3oyYyt3UU9PbzdJbnJYZmh0?=
 =?utf-8?B?WHdWak9vVjJva2pJaVM5bDVXKzdtOFdxR1FtZ25ZZW9vNDVvMnNEZDdyNkU3?=
 =?utf-8?B?ajdBU3VLSWxLTS9saFBMR3lQbnIzN1dia0N6YnRVbGlRbC9oeDhDdGsrT0c5?=
 =?utf-8?B?QkxCNGY1dnJZSXZ5R1NGVEdQRUNmZ29uS0gvWVc4M05VRHNZY0pyVGdMSEU4?=
 =?utf-8?B?bzdKbS9CLzZsS2ZRd0lkUU9yM3orbWRhemlFQk5IWXdBelltOGQxR29qNklh?=
 =?utf-8?B?cC9vKzlFRGk4WkxuUEhDWktnVTN1TWdaK3NsdkVKNWhDOGtHTkhKSEt3SWN6?=
 =?utf-8?B?cFA2NFY1c3NaWDNsZzh3d0w0MlVSc2RPZ2Z6SE9kSFB0aXhFWFNvaFgrQTQ5?=
 =?utf-8?B?Wk1lRG9pWHdkMWkzaTQ5N29XbXRhQ3FhbUVZTXhaUnZnSU5uTDJFejVMbkZ5?=
 =?utf-8?B?NG5wVjQwK3V6eTlNK1RBVTZiWnhnWlppS0dTYnpXdlhMOFdzZDhZZlNEMEk3?=
 =?utf-8?B?cGZEYW13cnlTVEgvVHBXTlk3YjdsYU8rNjN0RGNRZmJFblNXOFRtd2JjZThq?=
 =?utf-8?B?WlRUcXU1TDB0TDZJTDFhYWhkTGRDeFR2SmtyZEhTQklEbzZRZUxFTGhwaGdJ?=
 =?utf-8?B?SHQ4VkIyVnlLOU9heWFPZmNDUHEvOGZHeUtieWQ2aFpEZG5jUm9TQjk0c1B2?=
 =?utf-8?B?SHZnMkxWdmpmUS9lMU01dnpzMkU2WGxveDQ5MlZlN294VUNoRDJtSFlYYndB?=
 =?utf-8?B?Z0JaTmhGdlhCbnJoakZXeXl4OVp0d05pZVNEbC8rMmNSTnVaR3FmT2l1N1Z5?=
 =?utf-8?B?NVllaXI4amtnN3ZTb3FnTUlkOHlXRXd5Nk0xK3VNdHY0MnI4NXN3a0JwQTdM?=
 =?utf-8?B?SzhSbHk4UEhDNzZtY0FiOW5jRDg5L2x4YnZoYlJiYnYvNU5SNmRmY1ViSjZN?=
 =?utf-8?B?Vm44dVZtdEM1YWptL2drOS9GTjNCUFYvck44MzgwelhadzY1cEVoMXlGeGNw?=
 =?utf-8?B?SEJtOHo4SThpalFoRGlVd0QzZXhSZmdQRlVieFNKVHdrOHFvZi9rdHc4OTIx?=
 =?utf-8?B?N0hHa2JwTXgwVFFDMTkvdndBZzNrY3BWN2hBTStLNENwNlRZaU1TSU5nT3NF?=
 =?utf-8?B?dnd3T0NFU3JHbUltYmVSa2cwb2tHSVYvZGVTY0duVDRTdlUvTkY3UHFZTHFE?=
 =?utf-8?B?eEIrMlVmUlZiNXlublUyQjlJaVduYnF6NmI5TVFyR1RKcm40ZHgvSEJtdFQy?=
 =?utf-8?B?UWJudTQ3dlA2cjAyRFE3dDU0ZHlzWlhUbmJ5TnAyaG90dEFibWpJNnh5Mlh4?=
 =?utf-8?B?eUdTYjRsclVvK1lxU1JxVHM1NHYwYWdNOTBua21Ram9xdy9xejRYOVBpUCsx?=
 =?utf-8?B?MFdmSTFqSDhwdTJjNy9xVGlsYmtqYXdTYzNLdmJhYTRRaC93L3F5K2w1WHVT?=
 =?utf-8?B?blRFMHgyZVFpenNhVjUrUWExQ0JsOFBJV0FSeXJ4THdzbXhKR2xLU2V0UzZs?=
 =?utf-8?B?clNKTTJxaUpiWS8xT0NnM1FFV0NUWmpHbkJJWHQzaE50dWdqVUE3bkNBTDRX?=
 =?utf-8?B?akZPdm03cVdpWkREbVlSejFMZWdldm1iM2xCNU1yRElyTXFpYU5mWE91YjZO?=
 =?utf-8?B?TnZQcXI4MFJSdlV1V2ZlYWxMZmozMXBJZFlmbFFwRVdLdnJNa3Ywdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <973D5EFE67BB1E46B6C23D38688F8E66@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef21bad-80d8-4b62-fb87-08df45a573da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:55:02.5165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afn0DrAKfuYrAN1JRd0RzHzXySCcGgWd8zvuGdatec78OvY2mBGdeW1mb+JogY2w4zNNYV58O7CsTNLXKZZlRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

T24gV2VkLCAyMDI2LTExLTE4IGF0IDIyOjQ0ICswNTMwLCBEZXYgSmFpbiB3cm90ZToNCj4gDQo+
IE9uIDE4LzExLzI2IDEwOjM1IHBtLCBEZXYgSmFpbiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBP
biAxNy8xMS8yNiAxMjo0NiBwbSwgU2hpdmFuayBHYXJnIHdyb3RlOg0KPiA+ID4gVGhpcyBzZXJp
ZXMgcmVtb3ZlcyBmaXZlIGZ1bmN0aW9ucyBhbmQgb25lIHZhcmlhYmxlIGluIG1tIHRoYXQgaGF2
ZSBubw0KPiA+ID4gdXNlcnMgbGVmdCBhbnl3aGVyZSBpbiB0aGUgdHJlZS4gSSBmb3VuZCB0aGVt
IHdpdGggdGhlIGt1bnVzZWQgc2NyaXB0cw0KPiA+ID4gWzFdLCB3aGljaCBJIHdyb3RlIHdpdGgg
TExNJ3MgaGVscC4gVGhlIHYxIGNvdmVyIGxldHRlciBbMl0gaGFzIG1vcmUNCj4gPiA+IGRldGFp
bHMgb24gdGhlIHNjcmlwdHMgYW5kIGhvdyBMTE0gd2FzIHVzZWQuDQo+ID4gPiANCj4gPiA+IENo
YW5nZXMgaW4gdjI6DQo+ID4gPiAtIFNwbGl0IHYxIFsyXSB1cCBieSBNTSB0cmVlLCBhcyBEYXZp
ZCBzdWdnZXN0ZWQuIFRoZXNlIGZpdmUgcGF0Y2hlcw0KPiA+ID4gICBhcmUgYmFzZWQgb24gbW0t
bmV3LiANCj4gPiA+IC0gTm8gY2hhbmdlcyB0byB0aGUgcGF0Y2hlcyB0aGVtc2VsdmVzLg0KPiA+
ID4gDQo+ID4gPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL0FNREVTRS9saW51eC1tbS90cmVlL3No
aXZhbmsva3VudXNlZA0KPiA+ID4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjEw
MjYtdW51c2VkLXN5bS12MS0wLTgyY2EyZGNlYWJlMUBhbWQuY29tDQo+ID4gPiANCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNoaXZhbmsgR2FyZyA8c2hpdmFua2dAYW1kLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+IA0KPiA+IE9rYXkgSSBqdXN0IHJlY2FsbGVkIHRoYXQgdGhlcmUgaGF2ZSBiZWVuIG51bWVy
b3VzIGNhc2VzIHdoZXJlIHBlb3BsZSByYW4NCj4gPiBzY3JpcHRzIC8gY29tcGlsZXIgd2l0aCBm
bGFncyBldGMgYW5kIHNlbnQgcGF0Y2hlcyB0byByZW1vdmUgdW51c2VkIGZ1bmN0aW9ucywNCj4g
PiBidXQgbWFpbnRhaW5lcnMgcmVqZWN0ZWQgdGhlbSBjaXRpbmcgdGhleSBhcmUgdGhlcmUgZm9y
IGEgZnV0dXJlIHVzZS4gSGVyZQ0KPiA+IGFyZSBzb21lIG9mIHRob3NlIGluc3RhbmNlczoNCj4g
PiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MDcwMjE1MDYuNDAxODY3
Ni0xLUxpYW0uSG93bGV0dEBvcmFjbGUuY29tLw0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW1tLzIwMTAwMjExMDUyMjQ3LkdBMTUzOTJAbG9jYWxob3N0Lw0KPiA+IA0KPiA+IFNv
IEkgdGhpbmsgdGhlIGNvbW1pdCBtZXNzYWdlcyBuZWVkIHRvIGRvIG1vcmUsIHRoZXkgbmVlZCB0
byBwcm92ZSB0aGF0IHRoZQ0KPiA+IHVudXNlZCBmdW5jdGlvbiB3YXMgYSBnZW51aW5lIG92ZXJz
aWdodC4NCj4gPiANCj4gDQo+IE9uZSB3YXkgdG8gZG8gdGhhdCB3b3VsZCBiZSB0byBtZW50aW9u
IHRoZSBjb21taXQgYW5kIGl0cyBkYXRlLCBpZiBpdHMgdG9vIG9sZCwNCj4gb3IsIGlmIGl0IHdh
cyBwYXJ0IG9mIGEgcGF0Y2ggc2VyaWVzIGJ1dCB0aGVuIHRoZSBhdXRob3IgY2hhbmdlZCB0aGVp
cg0KPiBzdHJhdGVneSBpbiB0aGUgbGF0ZXIgcGF0Y2hlcyBtYWtpbmcgdGhlIGZ1bmN0aW9uIHJl
ZHVuZGFudCwgZXRjIGV0Yy4NCj4gDQo+IEluIHBhdGNoIDEsIHlvdSByZW1vdmUgbWFwcGluZ19j
bGVhcl9yZWxlYXNlX2Fsd2F5cygpIGJ1dCBkNzMwNjVlNjBkY2MgJ3MgZGVzY3JpcHRpb24NCj4g
aW1wbGllcyBpdCBpcyBnb2luZyB0byBnZXQgdXNlZCwgd2hpY2ggaXMgY29uZnVzaW5nLiBNYXli
ZSB3ZSBhcmUgbWlzc2luZw0KPiBhIGdlbnVpbmUgYnVnLCBvciB0aGUgYXV0aG9yIGZvcmdvdCB0
byBkcm9wIHRoZSBzdGFsZSBkZXNjcmlwdGlvbiBhY3Jvc3MNCj4gcmV2aXNpb25zLg0KPiANCg0K
SGkgRGV2LA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgYWdyZWUgdGhhdCBzb21lIHVudXNl
ZCBzeW1ib2xzIG1heSBiZSBrZXB0DQppbnRlbnRpb25hbGx5IGZvciBhIHBsYW5uZWQgZnV0dXJl
IHVzZXIsIHdoaWNoIEkgY2hlY2tlZCBmb3IgYmVmb3JlDQpzZW5kaW5nLg0KDQpGb3IgbW9zdCBw
YXRjaGVzIEkgaGFkIGluY2x1ZGVkIHNvbWUgaGlzdG9yeSwgbGlrZSB0aGUgY29tbWl0IHRoYXQN
CnJlbW92ZWQgdGhlIGxhc3QgY2FsbGVyIG9yIHRoZSBjb21taXQgdGhhdCBhZGRlZCB0aGVtIHdp
dGhvdXQgb25lLiBJDQptaXNzZWQgdGhhdCBmb3IgbWFwcGluZ19jbGVhcl9yZWxlYXNlX2Fsd2F5
cygpIGluIHRoaXMgcGF0Y2ggYW5kIGZvcg0KbWFrZV9ndWFyZF9zd3BfZW50cnkoKSBpbiBwYXRj
aCAyLCBzbyBoZXJlIGlzIHRoZSBoaXN0b3J5IGZvciBib3RoOg0KDQotIG1hcHBpbmdfY2xlYXJf
cmVsZWFzZV9hbHdheXMoKSB3YXMgYWRkZWQgaW4gYjRmYTk2NmYwM2I3ICgibW0sIG5ldGZzLA0K
ICBmc2NhY2hlOiBzdG9wIHJlYWQgb3B0aW1pc2F0aW9uIHdoZW4gZm9saW8gcmVtb3ZlZCBmcm9t
IHBhZ2VjYWNoZSIpIGFuZA0KICBuZXZlciBoYWQgYSBjYWxsZXIuIEVhcmxpZXIgdmVyc2lvbiBv
ZiBoYWQgY2FsbGVkIGl0IGZyb20gLT5ldmljdF9pbm9kZSgpDQogIGJ1dCBWNCBkcm9wcGVkIHRo
b3NlIGNhbGxzIGFzIHVubmVjZXNzYXJ5IFsxXSBsZWF2aW5nIHRoZSBoZWxwZXIuDQoNCi0gbWFr
ZV9ndWFyZF9zd3BfZW50cnkoKSB3YXMgYWRkZWQgaW4gN2M1M2RmYmRiMDI0ICgibW06IGFkZCBQ
VEVfTUFSS0VSX0dVQVJEDQogIFBURSBtYXJrZXIiKSwgaGFzIG5ldmVyIGhhZCBhIGNhbGxlciwg
YW5kIG5vbmUgaGFzIGJlZW4gcG9zdGVkIGluIDIgeWVhcnMuDQoNCkkgbGVmdCBzb21lIHN5bWJv
bHMgb3V0IGJlY2F1c2UgYSBwb3N0ZWQgc2VyaWVzIGFkZHMgY2FsbGVycywgZm9yDQpleGFtcGxl
IGZvbGlvX2R1cF9maWxlX3JtYXBfcG1kKCkgYW5kIGZvbGlvX2lzX3BmbWVtYWxsb2MoKSwgb3Ig
YmVjYXVzZQ0KdGhleSBhcmUgb25lIGhhbGYgb2YgYSBwYWlyIHdob3NlIG90aGVyIGhhbGYgaXMg
c3RpbGwgdXNlZCwgbGlrZQ0Ka21zYW5fcG9pc29uX21lbW9yeSgpLg0KDQpbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzE2NjkyNDM3MDUzOS4xNzcyNzkzLjEzNzMwNjk4MzYwNzcxODIx
MzE3LnN0Z2l0QHdhcnRob2cucHJvY3lvbi5vcmcudWsNCg0KVGhhbmtzLA0KU2hpdmFuaw0KDQoN
Cg==
