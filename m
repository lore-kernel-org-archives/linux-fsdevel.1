Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.36
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118173;
	b=wKEMUQmhS+OyhZDErMhaiDkhQLmoJxVFoPxaaWcUadFK2rWb0Y0ndUOL9Wbe2PogOya0
	 MNSq6yjCBaDkIAeUX9oqCkseJdMqkY93zt5n6ow5LPzFjQ04Av1bIbRTFLM4vf3Dukn0k
	 dcpsb2UWdKDMSZJH6FFpUksjQNeJyqJSQBQvNtSS7WYjTjHYvw/M1Qu6cF/oe95boOGhd
	 V4Q3tbFBCL/d8MVptLqk6i0lMZudgz3JbHi0SEBGqPGWEF4GbQrV4I5BoB7hqfe2T0rjT
	 Rs2ivEYJIjMyy9TNn9Ej9sriQXgHnm+DLAP+Qh4zbJfZhSZOA2NBt5qE1nEEzfcNACQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118173;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:From:
	 Date:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=unWhisHBfZCGZ41M7QiCatryMIpaAwN56OHvvAiSWbY=;
	b=mMM3PchLFwYf1rzvrveIy/lzoGY1rlEOoEol2wxyA+nGU0dOgr9dzQOl/KIX7J8NrWk6
	 BJtgNNtfxaLJRuT6b8r42bRjPoJC06MhbR9rbCnax33dnT5O98S/gCKWADDWsJLLFO8Ck
	 1v/Ozj887nXkempy60QtFucZNV3cMOiERl27MIOf7/Grm7aKbBKGIlY1YAN5NDqVQZAWn
	 3xxTofiNvTSkZHRjn63lOTSkOsWyZM5c7ovH4ngJuvvRf0X5DfkN5UA+CcPcgWIeOaQ4k
	 tzzP2gxAf/lDB3yTtKhhjasr9BJRvACVcxr8Oz3mesG8Gh20kRMF1nIbxDS+kHxh7SA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PgMkhIJd;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PgMkhIJd;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.36
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E09606A333;
	Tue, 27 Oct 2026 16:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E09606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PgMkhIJd;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PgMkhIJd
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=b1aZ+GmL3AhWSg9gfPXygbB8qAHY0CqPfsOHa8zPvBWmMvMgWFX7BtyBvAmC0KX4AU7OJGDQQ5Gjt4NDW6BC4auYaymiF3n5McHm8PCSPOgiL7XaMjbLFQH/aiCdhAkZOB7ZAXDwyu33Qj8q//KChNDJfMh3ffNrOAsXLx/V5+zMTBl6Yt3jtlNyR2JW8Njxrxi50UBmrwMRg2tUO0QTWZ4+LUpjp/lDZMI7x0wWvbR8YucPqf/5haEmpwpzyom9oLxcToOrcZY7mawuS7cKquQ3cfRGAEkAn39uTRdTTs8ps3Is25tueHo1mJ7+tWG0ULoYbeBs2LhQdTBRL6V05w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWhisHBfZCGZ41M7QiCatryMIpaAwN56OHvvAiSWbY=;
 b=ZbhQpVuu1s4k63QCm+22JwmCy/XbQaGGUOKcQzDlMsK7y7Yt9lXQtMwkoiUKC4SYFVa1VlCtBENCFDQYv8pht4tQ/RD0s7LcK4PV4dxQZZMnHesOO64qHgZEYxv0IAUHvrivhvhNm6A9zcqfH8W/tZD6ClNCLUrpggyBo0+AiZGkMxsqC+KuEnTbhcZsohffQqLNTD8Jr4Xljf2I0CjJCo3PMnRBVYpCfUdwC2XNlDfIrGkao04eKb5q8kqySABHG5qod949F7t52S9vsiwE6FGXA4VK9kLD0+Za3vGUcUF6kOTbaCGAJne97UA67Didr7ulA4AyTYyI7OJ6QXbUUw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWhisHBfZCGZ41M7QiCatryMIpaAwN56OHvvAiSWbY=;
 b=PgMkhIJdLmRhwI/VHWbOVx1+AyMmLizSo0s1euDcTqdWbGY656WQSFiR4vO6Txdy2LqMVIIhofpTPksjWvOgYiAoC15Q3IhUSqT+jZGCxa7IKgK9JF2VEL00siS0+AXrU6+SxwkfpLMV1TKVqSso/pFVgp7S/eqwktkHIQTR3PU=
Received: from PAZP264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::19)
 by DU0PR08MB9583.eurprd08.prod.outlook.com (2603:10a6:10:449::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:47 +0000
Received: from MI3PEPF0000855A.eurprd05.prod.outlook.com
 (2603:10a6:102:1fb:cafe::31) by PAZP264CA0095.outlook.office365.com
 (2603:10a6:102:1fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 16:22:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000855A.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Tue, 27 Oct 2026 16:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4zARDxZf9l4c/sJCgIuqfgNAvlidy9gDOfwsdg1xkrSvA1D0PVCBYIxjH9QTmy05ntnXYvcW3d2sCsrt9jD0nNySM1Wcve0juK49PVqo9cypdlW9f6fipoU0v6GnTz4TUDRugq4PxzYdPS4a7mzdU0S+muyOsopLDsq5ik9eLskuluS8oSU+JSUPSWLNPDKD5FwKkhylUpOGu5sCZUWELOsnIsTfE7X3DPSsl91N3Q/ZtcLTDEtJE5aG/dVEDSos9ObhpJ6e5dKgVTSGRD77R91PC27LBxLvYhPO7hZMielC77UZo/0AG9+E2ZO85eNPcvEqQ1ASw0nKhZ+yR3jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unWhisHBfZCGZ41M7QiCatryMIpaAwN56OHvvAiSWbY=;
 b=BiFFeK2O0IhxVwS8G3QpQIIPyaoxSUKKr3JdS22UKWW3ybPHJ1/tJh7AvXkTMWUJQXMFNrnJAPXYGSHDDiRrhRSzN9m4WJ/t9ljSRRsk1ti6oslonFNYP7CgHTY2c7CZQupQYuIfTnObK4N9aFyPjan0Qx1GNJ9/merdI5hAtu+bUyKU4e1DLWJS29ArmmobnMJmITyRMpNchSmTGvgpas8CKIvGLcDlCgav/HsvR03BcC7Gs4JrSrXbGwGpL9cRZCRHpwcE5TNXz0mk3JOkM9d7OUwg+GU0a9IGmDHwO4H8MDLn0jwa5Id2lqTgaorh3besocgM/ux52fK+Kbk4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unWhisHBfZCGZ41M7QiCatryMIpaAwN56OHvvAiSWbY=;
 b=PgMkhIJdLmRhwI/VHWbOVx1+AyMmLizSo0s1euDcTqdWbGY656WQSFiR4vO6Txdy2LqMVIIhofpTPksjWvOgYiAoC15Q3IhUSqT+jZGCxa7IKgK9JF2VEL00siS0+AXrU6+SxwkfpLMV1TKVqSso/pFVgp7S/eqwktkHIQTR3PU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by PAXPR08MB6335.eurprd08.prod.outlook.com
 (2603:10a6:102:12c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:14 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:22:13 +0000
From: Bence Csokas <bence.csokas@arm.com>
Date: Tue, 27 Oct 2026 17:22:01 +0100
Subject: [PATCH v3 1/2] eventfd: Add scope-based cleanup capability
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-efd-autofree-v3-1-caa2442e1beb@arm.com>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
In-Reply-To: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO6P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::13) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|PAXPR08MB6335:EE_|MI3PEPF0000855A:EE_|DU0PR08MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 745a54ce-c93b-446b-81be-08df344689da
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|261022105027099003|261021121427099003|22082099003|18002099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original:
 8b8vKyhESKRyof+0Qn3SQF/Of+r9oOwM9yVfepMjXA/PKC0t5XDmqK8H0CkdN1CCrdKuZMuBTXrbvHor5V/mfdLcnxVQeBLAo5H/QjGKTROM9sOpHn7Xra0QW+YflSStA++6bpNnf1Jlu8X4eUrZ9zNxW4LuRSK5o3pjnpQQpTTsocJibVJRc1s/XIV4OA2k20kqNGWtSVkLWYkVt0pRMgoWvpn/LHLxVY5nl9JcOpXzC2IuKWKEjG6ObxFfdlpUXzswe1WFH6sgF17O3IwY1CRfQVpKgXHYqTd+7pwwl7EFFOD+MW9d1pXb4kJb4YSaOvNn0YcMG/MWtU3cYhQi8C79p0pDa7YOusgY/qWzbM7xanL68lUOdljltMIds66Pu92BN2sJxNwJGya+vRYpk2d9JwV+TDfsADgDKRJBG8IuEkMHTy6Z5U3SFLhkg+8ZoMpYT7dsMjDal5myQ6GCf+f2/CqFA99hGuZywKJv62qnv0kP4tlc8QPXBXAT1iPL2X8bFSBbxBtje7DjixTI32z+N7B48fHViHGXVeGFSJH28jgtY1+xwG3zHFnqqPVj7Z/UVYKvqkezkkIBhzXvzLK1EVvSmhvj2Hw68fI1x5N9MLEnxvhXiUYXZMR7wjRMCUhWycJuREiDbdVsw7mdOWajol0uSEd8Encsl7bR6Rw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(22082099003)(18002099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 bzNEI84Q5NFc7XEdXO/oHm9YdzyKwnlGcuRi0yfNidQtoMOMq7BPQPWl9NhAQwa+pyhLypcQPcErMKDqo6v3NGN+eqxqnhXVCyfrx1NY5T5sRBC3T7Z0/Ner6LlnqARSdCTH2/KaKIer06OcBXXHsUDLEL5agRf8CZGVUqM8IaZcrQSKXYjbFpC1plrxifxB6Lih0ZKTpEJsuzerlRDNl4r6Z4cBBHtJPKw0oFKCdZrf/oIkrOvQFSHliNyGd362WjcSL2Vmz61ZhT5HGxswwkSeC++hkBce6JLUjp/fogVTBSCQ0T3RfQ4j0BLDEOlxhOzDW73bXPnzGj1pePXQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6335
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b22ec886-b16e-49ff-8866-08df3446753f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|376014|36860700016|82310400026|14060799003|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003|261021121427099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	oRbFbXCFa9UDDTeOCn6GGYH1NS/eXekMT04H1nSCaj24Uk0tplXcEqHdqTGJC0IT0v8tUuA2taek/oRsDzhfPFpE3U3b2A/HurTJyE3xLdDxqXnI8IVNXAgwalwn1bDGmJ0R6V/TaXgFxoXTNFVJ2sFsH9GIOmn5wK+E3RgFJoUzoPj+WpK11RDCLj7mQoEGVKUKpTPdguUXG308b/9kaJ2hMBmo/ak/Qo3aTeQN2Htvq6hFAY4eSa91h/ppVWeTigEIrfnkjCtJC5/MfvJFYfMve3PHDmtnKomVJRnG7tV+MCePBqiesrzj7cuXfEbWMfWxCQRdh1s4FGBNcX70Vdlipl4XWsptp/t7xeEThV4Y7/4idf0yUYfa0HO20cko3AH72NuylMoSZ83pESCbYfW8Wpk61/bPUt2T/CPINiHUJNZOutNL4qlY5zlsM5Zcaz+XUMNbZqEwGEhF8JZajGUH9lIVxJZDeVEb4UgJDazvpxvXesvpLn5zXGXNrx5gNIwstX3M8tX3hb9Cf3CSyo+4xoku9twwYCLcuX63ZqX14aylmxIzA+RRYGVr5VqwL2JCpjGf0+DKgxzpqgHa8yuCZqfSX8+G2qfip77jIEL8QHmaXZNou5fDWloyak59I2D19qgLGMB0Kq/ccztZk5kGFuSPDhnTGJYROGmkkHq84Yv4b1pazm012vhofjy4QpxNskuQZvjx3cbWcejM5w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(376014)(36860700016)(82310400026)(14060799003)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lrbzCVx9ZBLvFC3rDIcahgm4Ttg0Iqt4qtHnPsVjoEMmBmZw7zVqMH+MLXH0o+IdnoUO3tYp/TBXF+1O47meFGgi5PYeRAl2gSnlhRtIfkk2m/AaCv13UkvoabMWr0xNlLtG4U/y3bvG2ZIq6NZWeOJukqNzfBqNN9XsTouCwQm2Zsxag95KmOTOkrCZ1nzAxqngMrPoTAv0fV03t8d97CTsNH/QaBD0GMWdnW/kQ9Gy3Lk9WBPfdTNj3cudT1jFSobAmTTMjsBDuhULGr+w19m2NO49g8NxYV3j7BjG7WAs9IqVwWifXQW8gR4FVgB57nVOfF6Az8SZsOKWbNZnut2/C26nIWZNzOq93A1dv3QGZ3hPrCQ2QEv8bVMZ4yGxyzTBCJ4kmGSMh66lVZoSwL/lf0GfDjuhtDLLVxQdkQKkPU88Bu26pTg6wOB6eB34
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:47.3190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745a54ce-c93b-446b-81be-08df344689da
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9583

Allow eventfd_ctx_put() to be used with the RAII-inspired __free() API.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
 include/linux/eventfd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index e32bee4345fb..48c40f8c4dfd 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -10,6 +10,7 @@
 #define _LINUX_EVENTFD_H
 
 #include <linux/wait.h>
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
@@ -89,5 +90,7 @@ static inline void eventfd_signal(struct eventfd_ctx *ctx)
 	eventfd_signal_mask(ctx, 0);
 }
 
+DEFINE_FREE(eventfd, struct eventfd_ctx *, if (!IS_ERR_OR_NULL(_T)) eventfd_ctx_put(_T))
+
 #endif /* _LINUX_EVENTFD_H */
 

-- 
2.56.0

