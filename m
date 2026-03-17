Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F83644BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740105; cv=fail; b=q8VxDBU701WSamizvMVy3QDhuVqQ2Or1b9rFVy5hC0yjxW0pEYhVUXJd9VC0PrJfenQdnzggV9WvVDG0eudR/qTblGNu/+l1maIkChIxbuO+y16dHjraGoQbYDQXm1uQi8hFOhjRKHWXYXJ3+Y8I28FejEBXaHkYQhw/OmNJwnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740105; c=relaxed/simple;
	bh=lS64IsHesYBefV+X4mVT77/3Agt+6eGeX1KU/ibqydI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K4g0iOx1jKPjTHJyWTK4GIVrZl+9tIixbZ32CjIXY6RyVc2iM85PRr7JLnehdNCF7lk58Vr5X8OVFsqg9q7dsafeJXMbwIVhVmUM/a7fMAoOEmuiByC9wcOR7+Ifa7GE9S4tLTA4292QOA6/yaHc0iHNqCGn0pbDzCiXZ66RouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gs7lwUTj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kz2pdYgd; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gs7lwUTj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kz2pdYgd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773740103; x=1805276103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lS64IsHesYBefV+X4mVT77/3Agt+6eGeX1KU/ibqydI=;
  b=gs7lwUTjopiDiGw5rSYIhv95ECLO4OwlkXe+//MXcKFtg8M1yC+S9lFl
   iXpPyTy4CTTLiWtzYBufhZqSEr0AUWy7bSJZC/wqla8dGFbRJ9dS0/QZy
   xcfiKyV2Zz9lsKqQ+FWuep2s2+OiC54CLDq8z8UuubP0igv65vE58R/u/
   ty29kG4xN1+6TRNJoOYBNCFJ1RPK4Uw0JySA5cqoqLfKYYrAI7Fbgt8iv
   5JZQJ0qyLO+Tgqy7ElcfY6JJu8LfBMLmCBl2HeNob0/R+Vd3BoQiiBcHg
   bmmMs+/xooORCN4KT4/qIjpGNO52GCjoYIc+n0kAhkoVm3BWK0gZloseu
   w==;
X-CSE-ConnectionGUID: OvxmhzcsQ9S30h9J40ZOfg==
X-CSE-MsgGUID: N1w7u031RMWEqZFnAdcOjA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="142678600"
Received: from mail-northcentralusazon11012033.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 17:35:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0WHKV0wv2gBbqq9hGL1LWJuEAeGMCm3GxWnEiQ/qkqdotUXY2lmxrmsrabLjzl4kOsLo4Mw2tJP7d8szOewt/pIa+JM1vwLAhWgfwqZ89u0xFR0Aq2Ct+/qedgkx38coA7K9b/zz9BHYpmzaaYgzwuKrZPqQW3RTv30CzsxY/oYOCoFAxsrHYFCCHekeKT69TmJzccgHL6l4WAoOagk7QKjfNNvAL5rxV66QbrDxNUnNLR53IaEw1scKLaoTEI5mwEThDMX5iO402E974MOt40UezK88RfUDXJ3WAJJxf7JMYVyP+HFMwv6p26NXlxvRCqUlgGPBIJ8lCEvlpuEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS64IsHesYBefV+X4mVT77/3Agt+6eGeX1KU/ibqydI=;
 b=pLlUW/c2VTfC1svpDYy+qEtTq3wCFfHA3J/6JwGQv0oiHwDbCCX4kKHbMDDlLKEvmIxj5/EKGJK5zFNkFfhr55jY56OD/k7VVvnPlEPyOPPwzLi0+Zlsv4WILrnim7ZpEUp2wgh6O96ZOp5qtbthsypc1oEE+ckYZMHvV9x8W5QxPtWKHroGN8fJIloMRKzo83XmhJ+mWKpgfRMDADiGZiPTowdRH+W64BlBHZlNig3p2WHBArt5qVEQMnG/QxPeGITMDedU21fEh3pZSlFqX1ki5+Or5m9T9qkAs8sMmb1X8T0dK+pZDm8rG3APXTEfIJBRqvKaXW1IsxGgDouftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS64IsHesYBefV+X4mVT77/3Agt+6eGeX1KU/ibqydI=;
 b=kz2pdYgdXNFtfCv07b5tnPXL5IZX30yF2Xm5MGLXXpa/j/2L5A3tp0w7+Gy81NbOx3dWTKxrgzQkPTA4KZFGkAVn+synDRME5PQz32RCJpr078/2sdgmHEWqxamc32R3dZBOeOFTByEtqAf0VV/0xwitrPb9Zl0LS5V/p7C5bR0=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA1PR04MB8825.namprd04.prod.outlook.com (2603:10b6:806:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 09:34:29 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 09:34:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: joannelkoong <joannelkoong@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
Thread-Topic: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
Thread-Index: AQHcr+L+JUP1D/qCgEyjtOWbIuNrhbWmrpsAgAD4AgCAAJ2yAIAADR6AgAoxcAA=
Date: Tue, 17 Mar 2026 09:34:58 +0000
Message-ID: <194b3338-ec8c-4894-a03c-ac982170c6a7@wdc.com>
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com>
 <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
 <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com>
 <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
 <CAJnrk1ao_0tp9oe2kisPPgY43YRqrQV=-GHSkgiwx_+WPUPD2Q@mail.gmail.com>
In-Reply-To:
 <CAJnrk1ao_0tp9oe2kisPPgY43YRqrQV=-GHSkgiwx_+WPUPD2Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA1PR04MB8825:EE_
x-ms-office365-filtering-correlation-id: 7506d84c-0836-477c-3df2-08de840874c7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|10070799003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rxKqLYP+uSr6sucDDR6iFG/sbnilhsLc8BcEdH09Gaehn8q7rmbWonYfTY5ec9GvLssHjU5Yie/id07joYb7gRCLc31SvXhJ4giQz+Ng71TrfCeRQtNslsR67XEH86ooe4nn0TEvujzdmUl/srlB3tAb3LQ+kF83RsxHyc1lcjvvmKLJvpNGkwnUpXVdjpQFfNOUa9eerGKGbcKTyAOVh4el5pEJZfTFJpWiIHqDccShkEUbLnJdW/xKG+QSj5JlxDSmOj52pE601lK3mLNhtKB6qoPh5CHLICd4T8+POQ86rgq5NwvQXOHOjQtwoQQcXkjCfobGbzMgWNYa5W81UlV6JV01ST47/6gpt/oXwOHYFmJY40amnMaysvxD0GODm5Ecy5dDMcR7qqX0kkLoF8GlSI8TCro8g/clvD07om50rTYcXbM7P5Ncp3EqTm2En13V7hqMWxfVyv7+XkVHIPjYb8ZrE3sU0SZbEN9pCoNi0X1dNDrwec6ZmCU1OIjMQIxqO6CtofbctLqTAZ8+zOc0rzAvM/wIaOxd6W9fLOuqP1BJ3M2cDlsH0HPYrtDjafx1LtbW5Sh7Pka/oZZdHWLhspQmeYDUDjPcQEdXOELO/K39F4HlHUYSDIy9hL0ISbusJ+Pd5zftQhxmLzsUWlsjdcJjK71JWUCrY6hZerMlH6nWEIJKL4/vOdmGDW5vAEKbph4QezlVFkYwICKeSitgAy6pzWKwwwdWsnmWI4NUjO3jlsVS9X+DoqwEqdwYIdEsq9ACYyYteQtcJdh5xpd3jKm0+m3Jm9sf4EKfZAg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(10070799003)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGE2dHlVaHBJMmxMZWs1QWNheEs5VUU0SmkwR05KYVM5cUVrVkcyMDFVKzkx?=
 =?utf-8?B?cWVzYmlzTGFBRkVyWEJBK2trdzV0OFpadWJOU3F6ZEM0YURGUVV1UlI3SE1r?=
 =?utf-8?B?ZU8wMVJZdGRLempSNHY1TjY4V3N0WlBnQ3FJMERWQzZhQjdKSWFIQmNyNjRL?=
 =?utf-8?B?LzJEMCtaMWZPME5Rb3VHdzZDUGYvWTRHc3ZwT3RDWGZJaHh5dlR1UFlIek1T?=
 =?utf-8?B?a1JGcmkzZEhpV3Z1TGlvU05RVkdrSzl0eWFUVVBVa1VnVFo2NEZZdmJiUXBu?=
 =?utf-8?B?SmcvNER2bDVBamRsYm1xa1o3RVM2NWcrUUlvMER0a3RrRSs3Ymk4M2p0bkkw?=
 =?utf-8?B?M0Q3Z1VNbzI5dCt5bWZMWEZSSXhkMUo2anJEeXphVXJQQWdtd21vUXkzZ29H?=
 =?utf-8?B?QnY1VW5JWks0NWg3V2FsM1NvNFlZYWo2ZWs4dnVoOUJWUGFrZG12SG5ZdXJY?=
 =?utf-8?B?YkR1UGpLWmF4ckswdGZKYXFvZ1oyRmhrMFgvR3dnOTc3TGJCTk5WNHduaEJx?=
 =?utf-8?B?N01NQTU4YTNYLzJhMm5FdUtlSThEcXRtejUvTWh6ODR0TytacDgzeXNWU3Bt?=
 =?utf-8?B?ME1XemJBOU53SnhDRXRyZzhIaVpaRE9qRHBvVWtITXRxZ3J4YVZiZTJXQlhm?=
 =?utf-8?B?MGoybzBvVFF4M1NtSTlZdWdyenBFQzhMT3hqNXU3OGJlSW44dFByV051NXk3?=
 =?utf-8?B?bjcyNEdUd21mWnhncXM5emd2ZFJIbVNqTHo5MjZMeklDa2FVc0ptUlVaTlYy?=
 =?utf-8?B?d3V3VVQvNTBQMlE5SXJEbTBRMWxyc0tLektMN0NGY3lYaXVWWHYwZWR3T3B0?=
 =?utf-8?B?aEJwNE5NSTQ1dzQvWWpBYjhtWUlpNkx3cVpndkR5YVN0aWVOdnNodm51akh4?=
 =?utf-8?B?Z3dLVU5GaXA3YmVaYnlSaUIzOWJDd0VvdkZjZTVnU1FPOXM3a242QTZXUjdU?=
 =?utf-8?B?VEtQQVRRTU1aNWFQTWQ0SDM0NnlQckRzQ1p4K3QvWG9TZ1pZbVlrQ2FBY011?=
 =?utf-8?B?NEdhYnljdEdBSmF1dW5kczAxbUlqT0pMTFhKSTZyMlM3dDlqNVlJeHh6STNz?=
 =?utf-8?B?K0Uzc0tRV2V6TVRuOEYvQTBNR05SSzA4MDlCUjYwWlh6NE5HOXVCeE1CTllH?=
 =?utf-8?B?cHhkMURLaFE3QTdmUHJXN2pIYWp6REl1M0ZKTEY3S1IyMGVBdlZ5K24xOVNu?=
 =?utf-8?B?TVJnbnl6UDJ0ZTFJRityTm1CSUxvaXArRktaaGpnenlybmtaRk52VXZwVkh4?=
 =?utf-8?B?UGVlQ3MrZjhHam1lY2M5c3h4MnE0Q241bTF1Z0g2anpyZEY5UlgxZ2ZTYzUx?=
 =?utf-8?B?eGhLL0Rwa0hWTC9VZXl4NW5razdDcjE5WDIrQWRSMm9MMUZQRDBjYkZZcDVV?=
 =?utf-8?B?VjNQUmFUeFFCYTczSUk3NjZpbXdENkJWWUtvanAyempFdi9mSlBwbGpjQzN1?=
 =?utf-8?B?OHFwMlo2eHdyVjFKNTNqSEd3b2hzU0FWaEhXeUExeGRyK1Q3QkMrZ3JjWWFI?=
 =?utf-8?B?cUlhYndTeXUrVmZBbG5FK0RUbms5UkVETG5ZeldwVHdMWmxUdDJHd1c0WVAr?=
 =?utf-8?B?M3Brb3EvL253YmcvaTJhTUlxcENUVFZrdXl1clBXd1JYVXVVa0lMR0lFN3NN?=
 =?utf-8?B?VCtYZzFUb1NocFRvMHo0czZhdVlkRDdZNURWSEl1UU9NcWwwNXNSM2xDV21k?=
 =?utf-8?B?aStjOFRoTm4xNGRqTFhPeVhPVVFVV09oK2h6UnlIUDdWWE5LQU4rMEhtSUVS?=
 =?utf-8?B?aXoyV291WlhEOTZBaml3RjBhcDBXSUZWbUkvSnlzd2lja1VQNWdaYkdXRHYv?=
 =?utf-8?B?YUJuUi9UUkFsQjdEeE5qcEo0Y1pNWXRNWE9DVlM2K2xCUDByNW56Q2Z4dE0r?=
 =?utf-8?B?RVdPNzE3cUFFRzdYL0FtbzljSDJIdXFSU1hQR0VRaXN6VWFBNjJUbWlPVCty?=
 =?utf-8?B?alF4VHhOTWJjWG93ZVBzakRwQWVZTXJFNTN0WDgyM3Z3L3JGaGxSRHdESWV5?=
 =?utf-8?B?VzNNTGN0c0Fqa0l4dHRhQmVWZVRVMWMwblFsOXdCZWpqTXJGSmpVK3J5ZWtH?=
 =?utf-8?B?Z2ljU3U2VTNNbXNxb0VEMnpYMnppemJPVDFUUHpmOExRNkV2VytkL2p3V0ZI?=
 =?utf-8?B?eFMyRnFLdjRlMFpSOFVkeFBSdXdGZlFtVU1GcEpMRk5yaDBzSktoOWNhcjZr?=
 =?utf-8?B?aXlWUmZzZXkzcWFwamQ5N3ZtaGE1aGFDRHh6OXJlYkR6S01ha0MyODFDRlRm?=
 =?utf-8?B?YzJVZVJHUUg2ZHBrQW1rM2o5QlpQUGZMbkZNOGRhanBNZnU2WXlxcXY4OVhq?=
 =?utf-8?B?bFkvWFYzNDF5N3k4SFZ2NTI0ZnBZQmwrM2dTNjRkaGhJNThZQ2dGajlaRmZm?=
 =?utf-8?Q?EjOpx2zT04PdGNk394ZfK7ESNbaBHMrlwSoNXseFgJuPz?=
x-ms-exchange-antispam-messagedata-1: bfmW0nVqKKYWRtKf8tAVDTPLF+grX2hOvR0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8227E6CB0B366D4E8CCD4D1A1DC315C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Cvl1sybhphE2qPnGkiiT8pFbPZkB73dBSBzXEgG3/5DrPBbsTActvZQdVg+JDjFlBYCRe2vlhrxU591MrbKw1nLER4UfyDkYOQz7HqxhbrIiRge5tReHUS+Mxoh6bkku+K9tOplXQ86ol1I5J7RiIO7ODKZ6jobFkOFZ3IYETRWGJhpKMt1bCC+4DVFVhJEpQ/yIPaolErC1Ibd9XlMym7YOpqRNBx2OEYsN1gcsZmlx6isLFoJ0oWeVClx0nZ8+4oY5UG03ffeoJiogvmOuMAz99ejjXiqSdi9xaYk42sltDoUDq8syjQ103FuGlVmgNTBRXvbdFAvNWt9KvC+mWw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lqlOURMYbHib2vuhIXLMu1vJERwXTw38BbpQlWVEk5vPbhuYukLDne70dFMLUTL6244/Vt6pWu1i9MCPjH38nbEkTd+4uV/vrHL0wsMOaBjkWTUjOk5fRUqOkKZR1B3E7/4c2ZHV5H/bhi2zGcraqQRpa3TZjZEjn0loQf/3QlJBkeQhXQ0T0om2bfyg2Y4WDyIwe6RErC7u687dqvU4eSHIjcbMQMk8/Qqg9sHcy/YqBjpYt+adXDMIGBub8NF6ajtu4bc4c5Ko92rk8xoKlwHnnbvMkFjCKrPQHlgCXdhY6V/+6V/PFySb+71Ey+jws/XBpPRzOuuF6WV4UG6XLZxjzqZTtPbSetRKeMNvbEMixriYYK4WV2vj9g61zhHqNMKkYla9L+G3de+HZ4qilorL+5lf8mdxeUXyQCyzKduhg/HcBP+qIQhcBUY4gE6H0oVOtsyZSbLf2Hj+sEc/YEziXDjLViKCrM+42nqxR+M+5my5CmyKXIHjGbehVnRQe51VTTJkxPfeUpWyy+HWwYrxRWH7YxJi6d3fd+yypwah1quL6wutL7zvrKjU3athIigOtf22aTYAYhLc4fgkjMHA7aKtMPfxGlOjE1T8Uu8XEJogaPe5iQ8pqcpPQU9B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7506d84c-0836-477c-3df2-08de840874c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 09:34:58.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgVfi6p2I1F5ycnYWdmOPMZVLSODapa3g8XAL7cmtYYO1KrIpvkk7T6usCXpb2V6KtUguDHHn35WfMrDKAyuW20W+1+wrsoFVsCHVctrKJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8825

T24gMy8xMC8yNiAxMDo1NSBQTSwgSm9hbm5lIEtvb25nIHdyb3RlOg0KPiBPbiBUdWUsIE1hciAx
MCwgMjAyNiBhdCAyOjA44oCvUE0gSm9hbm5lIEtvb25nIDxqb2FubmVsa29vbmdAZ21haWwuY29t
PiB3cm90ZToNCj4+IE9uIFR1ZSwgTWFyIDEwLCAyMDI2IGF0IDQ6NDTigK9BTSBKb2hhbm5lcyBU
aHVtc2hpcm4NCj4+IDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMgYi9mcy9pb21hcC9idWZmZXJlZC1p
by5jDQo+PiBpbmRleCA4NjdlOGFjNzYxYzguLjAzYTk3MzYxNTcwZiAxMDA2NDQNCj4+IC0tLSBh
L2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMNCj4+ICsrKyBiL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMN
Cj4+IEBAIC01NDMsNyArNTQzLDcgQEAgc3RhdGljIGludCBpb21hcF9yZWFkX2ZvbGlvX2l0ZXIo
c3RydWN0IGlvbWFwX2l0ZXIgKml0ZXIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICog
aGVscGVyLCB0aGVuIHRoZSBoZWxwZXIgb3ducyB0aGUgZm9saW8gYW5kIHdpbGwgZW5kDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICogdGhlIHJlYWQgb24gaXQuDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICovDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoKmJ5dGVz
X3N1Ym1pdHRlZCA9PSBmb2xpb19sZW4pDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
KmJ5dGVzX3N1Ym1pdHRlZCA9PSBmb2xpb19sZW4gfHwgIWlmcykNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGN0eC0+Y3VyX2ZvbGlvID0gTlVMTDsNCj4+ICAgICAgICAgICAg
ICAgICAgfQ0KPiBpdCBzaG91bGQgYmUgdGhpcyBpbnN0ZWFkOg0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyBiL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMNCj4gaW5kZXgg
ODY3ZThhYzc2MWM4Li5iODAzZjUxOGFkYWYgMTAwNjQ0DQo+IC0tLSBhL2ZzL2lvbWFwL2J1ZmZl
cmVkLWlvLmMNCj4gKysrIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYw0KPiBAQCAtNDk3LDYgKzQ5
Nyw3IEBAIHN0YXRpYyBpbnQgaW9tYXBfcmVhZF9mb2xpb19pdGVyKHN0cnVjdCBpb21hcF9pdGVy
ICppdGVyLA0KPiAgICAgICAgICBsb2ZmX3QgbGVuZ3RoID0gaW9tYXBfbGVuZ3RoKGl0ZXIpOw0K
PiAgICAgICAgICBzdHJ1Y3QgZm9saW8gKmZvbGlvID0gY3R4LT5jdXJfZm9saW87DQo+ICAgICAg
ICAgIHNpemVfdCBmb2xpb19sZW4gPSBmb2xpb19zaXplKGZvbGlvKTsNCj4gKyAgICAgICBzdHJ1
Y3QgaW9tYXBfZm9saW9fc3RhdGUgKmlmczsNCj4gICAgICAgICAgc2l6ZV90IHBvZmYsIHBsZW47
DQo+ICAgICAgICAgIGxvZmZfdCBwb3NfZGlmZjsNCj4gICAgICAgICAgaW50IHJldDsNCj4gQEAg
LTUwOCw3ICs1MDksNyBAQCBzdGF0aWMgaW50IGlvbWFwX3JlYWRfZm9saW9faXRlcihzdHJ1Y3Qg
aW9tYXBfaXRlciAqaXRlciwNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gaW9tYXBfaXRlcl9h
ZHZhbmNlKGl0ZXIsIGxlbmd0aCk7DQo+ICAgICAgICAgIH0NCj4NCj4gLSAgICAgICBpZnNfYWxs
b2MoaXRlci0+aW5vZGUsIGZvbGlvLCBpdGVyLT5mbGFncyk7DQo+ICsgICAgICAgaWZzID0gaWZz
X2FsbG9jKGl0ZXItPmlub2RlLCBmb2xpbywgaXRlci0+ZmxhZ3MpOw0KPg0KPiAgICAgICAgICBs
ZW5ndGggPSBtaW5fdChsb2ZmX3QsIGxlbmd0aCwgZm9saW9fbGVuIC0gb2Zmc2V0X2luX2ZvbGlv
KGZvbGlvLCBwb3MpKTsNCj4gICAgICAgICAgd2hpbGUgKGxlbmd0aCkgew0KPiBAQCAtNTQzLDcg
KzU0NCw3IEBAIHN0YXRpYyBpbnQgaW9tYXBfcmVhZF9mb2xpb19pdGVyKHN0cnVjdCBpb21hcF9p
dGVyICppdGVyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICogaGVscGVyLCB0aGVuIHRo
ZSBoZWxwZXIgb3ducyB0aGUgZm9saW8gYW5kIHdpbGwgZW5kDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKiB0aGUgcmVhZCBvbiBpdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAq
Lw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoKmJ5dGVzX3N1Ym1pdHRlZCA9PSBmb2xp
b19sZW4pDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICgqYnl0ZXNfc3VibWl0dGVkID09
IGZvbGlvX2xlbiB8fCAhaWZzKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
dHgtPmN1cl9mb2xpbyA9IE5VTEw7DQo+ICAgICAgICAgICAgICAgICAgfQ0KPg0KPiBUaGFua3Ms
DQo+IEpvYW5uZQ0KPg0KVGhpcyB2ZXJzaW9uIGlzIG1ha2luZyB0aGUgdGVzdCBwYXNzIGFnYWlu
LA0KDQpSZXBvcnRlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5A
d2RjLmNvbT4NCg0KVGVzdGVkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPg0KDQpUaGFua3MgYSBsb3QgZm9yIHRoaXMhDQoNCg==
