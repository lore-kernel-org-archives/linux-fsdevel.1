Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022141.outbound.protection.outlook.com [52.101.96.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0403A4F5B;
	Sun, 12 Jul 2026 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863654; cv=fail; b=mHWFPSIwP3EESz0Js1cMNk5k2w2xhh8FEVRgZW0P/OsSFvkBpl3oSi3CMMPpxxlSzZ3fXp5Hz9Fu0y5w12aiH053KfRa1ryt5CW/LkrJow1TTuKFIQa5+6d8W09Kk0wirVn0EcrjZNQOnbhS9hkUacprf3SXq71T37z+MJQ3uIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863654; c=relaxed/simple;
	bh=4vq5xFlZ50UghAnSEQC4rxM7cBJflveYBG8QZR5XFkU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=F1JKvASLYohIjkn/Rhpi/0QtLuzSbRwTUmqhErPB5AyeUuATBfMby9EFmnaFBOeiJi90JUr1PcQiunRIvC8Lb3G7EP2lU4+3GXGh2TY44Qt9w1Ic2stbOOzXA0G1NgcwdXShH9aCfi+Xx4U03afHWLo1McUtAFoxKzNVqh43458=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=H2wUVqQU; arc=fail smtp.client-ip=52.101.96.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="H2wUVqQU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6uEeNEYkDeDeuQvuzSGjTqY7Q9GML8HBecCrXAxYEwPF2OFMkcP5gDhQj7br2GqnzhIEaJzJrVU8NYOAdZNc1obouuGg/oAG2mx8mPxtxtw6F2Xdfb296Sh8CszW0m1yWCdcJZ+EcWwQNEVJtRtVgMv2EkNgEN2ynXvIjrqI/7MKB0i7Qnb8FapUFZ5wNylDdfzfktgd8fweB+6+qCggxcbNAWgAnetiaQKtIE0sEtP2CKQwSFY+WE5zHtP9fb19bmJewqFVs/Qa6B138jt5GZa1GT/5XJNlMUutmvvt6Hsv6ZUa/F2EnIt5eWq1QvWjs6oXZF1cI3EmdJNxD/WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vq5xFlZ50UghAnSEQC4rxM7cBJflveYBG8QZR5XFkU=;
 b=nr7TBCBDEt6j+wyiNc/XGjBJEzE5ygTsYLN4x2khs7JAfCQAGkBAW8uMLcJypZQBCnT/fmUNubjod1FF3FKo42Kg0ndqnUgq9eNSaptFB4DWoUVi0dHN7RkM9zobVFBYdS9u4GKTGWdduBr4WgtK6p+v+PPMUySb6zzFd2MgjWA8KcPjqkrIGbHs0pBK9gUvsid+UrXpVFzNOULYRJESHdrgZn2HnOYnqT2gdu974xVkaFW1YWVqaAsXjWHcwZKNvqSEZ1k5uuuu/R77Mpm0FVpisHne2JTO2Bo/Hi64sQ/ehfeR9TgaCeuAk13M/ItqCClIgIjW5i9/WfeB6blkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vq5xFlZ50UghAnSEQC4rxM7cBJflveYBG8QZR5XFkU=;
 b=H2wUVqQUYsuATgLTAFOa1xIpiX3EcaaisR1Xrvt7kTWwhdFZ+pYfNRIKsKx382l8tpxOFeUeo0tA6T0Xhbu9ZqO6aroex+35QJEF9NFSiEJNmBUjvBLmwcyMAcAPHkd1egUNmXOc34+CTP3e/89EI3sS85f1tr1hPcSZij77g+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3313.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Sun, 12 Jul
 2026 13:40:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:40:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 14:40:48 +0100
Message-Id: <DJWMVYQ3TTQS.2L7BV8YNBROAN@garyguo.net>
Subject: Re: [PATCH] rust: fs, hrtimer: replace read_volatile workarounds
 with atomic_load
From: "Gary Guo" <gary@garyguo.net>
To: "Alessio Maroni" <alessiomaroni0@gmail.com>, <brauner@kernel.org>,
 <viro@zeniv.linux.org.uk>, <ojeda@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260712121420.25179-1-alessiomaroni0@gmail.com>
 <20260712123502.2829-1-alessiomaroni0@gmail.com>
In-Reply-To: <20260712123502.2829-1-alessiomaroni0@gmail.com>
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3313:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cec6304-740a-417e-5e1d-08dee01b2ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|23010399003|22082099003|18002099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	01DU3+8EAJqU/Oh3jkn+/vhAupeCTJg3HULHmmdSHXCJYIZQhRlRC+yFJSln2pAWAQRzv/u2hsXOLLLtRcNRYUMz7CuJ81TJh40DwY4MGM3C4F1PM8/PvkRrs/jFnilf37MkfFNPJr6TNpRNENLbbSGP294+T/g3TUvVPSTDY135aPj9fWVTYdnNidTSsZLcsa+qGtF3AYd2xpnNrhrLsdyAUmG3BLRY1rxZXb9lGzdn30wlEuVw3AI2Hlb2KkBitCmL+T0fEA0/9XK2Dlvyo0ba0p6Xa0A+e0NfUdkGaXuw7vzn/BJRAgxZJReE6aeyR+eSn+s7YmBfYvZiftKiuPgtk0ZORYo38If5P8Egt7+DvEq3Dx1zZ7aFt04vka7rStW1Huzfq1kdF26bOcBSeeP0gATa0h6Lmi4BHiZ66hGyO06bE8JuF83IrUhvQsuxsXlppryxnGTdOJRGgzTM1jZAjAPvACq5gyOs697Yobfyfac7kBQnAM582MP88KsyNetRKx4HRNNSxIf9sdr5uC/0zAXmzvVjMT4ngj4aC2Tf+ma8LH63u8njdlkIkByRzow2dWrTKhPp1Azmjwtgq/BfRqtQZfJ62JOuJMWOtoIwFh88AmO9kZzyjCLHzLoAb6pFgmfMPLeo3EGaJYZ/cfK0ihCJNluSCjm6QpPgXJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHorU0dGRGRjVHViM21XNk9Od3NkYmZ4WUwvNG1CNWRYaExOcUU1VndibTRB?=
 =?utf-8?B?NGxCemNGbDUvUVJJVFBvSWhYb3Arb2VyazlYcUF2Zm5TRnZiTmxLWjBISEIx?=
 =?utf-8?B?bUVsTSsvcWMwb0llUU12bjNNTmFmV3JOdUlYelgvcVZsZWZWeEhTMXZadVhx?=
 =?utf-8?B?QUI4cWpvRllhbC90TkM1QU42cGUwMjRaRG13aTFVNDdXR0hxZEJsbVFNcW5k?=
 =?utf-8?B?QmNXcng0ZnFna2RjczBxbDNHbWxXQVBONVhYYTdaQ2xoNEtISjg4clc5MFo3?=
 =?utf-8?B?T0VBZVRVdnduYjJ1RklOeDRVeTVEYXF1dVJiRXdjMTFUQUYzdUhpQ3JKYyth?=
 =?utf-8?B?MEhzQWd4dnBrZVVJU2pWUFlaWTBOVHAxNkJ4T09SaFlhTll4WWtKbXdLbkJL?=
 =?utf-8?B?ZFJrQ1hhWHpoU1VMK3RRTVp6dlc2cVJ2aXYwOFJ3VUx2Wkc0Yi8rdXRlUHVC?=
 =?utf-8?B?bVRjaGdSYStnYnoyeW54WTV0ei9Cd1VxQlRxMHZlcUlpVUFaekM1dDcySW5i?=
 =?utf-8?B?dFEzVGF6RGlrS2c1OXVjaGUwWWJYY1V4bGw2VDBMRTN5YzFZU0FTNXV3SVFk?=
 =?utf-8?B?TG05WlFlckJlSTkyRStKcUlhMDBFeGVkbUxxZjg0dEF3RkJINTY2UmZLVWw5?=
 =?utf-8?B?T1RUR0hycXVUTW54ZG5LM0hsZUpjd2V0WWIrb3RkS2Z1VGtGNmlxeHUrc3Nt?=
 =?utf-8?B?TzlHcVNBQStWOEVpR2xXK2UzczBQbEQ3WUkwNHJ2UmhHMEtkSktwOS9XTWhT?=
 =?utf-8?B?UE9ST0VzWEZKekZINTVaeUpOOWtyTGpJdSs0QlJFcGVFNG5LZlVjc0NNZ3Jq?=
 =?utf-8?B?NFQ2UXhlaFFDZzNINlE2UFhXNXhxZWh5SURSejRmT2h2aWp3OEZCcDhDUi9q?=
 =?utf-8?B?d1VaQy9hN1NzVTlOMExtMFgvb2s5QUJ0ZXRVenk3UXdOeGtQUGNuVlNGMHQw?=
 =?utf-8?B?djVWTlFDS2pCS0YweG50Q0JHb0RxWjZvcmd6bVI3MmRaTmtLSWk4NXJsUmp0?=
 =?utf-8?B?aWtQNThiR1dZN0Rkcno5SnY4NERxUE04aEljZHArbWxDLzFGYUJoSHNrR0Qz?=
 =?utf-8?B?N3d6S3BzSW1HOUg5TmloVmQ2RHZNNDRqSXRmYlBzeGdXQUUvL3dYZENERys5?=
 =?utf-8?B?emZYajgwdzQyb1RYbzFldmpsQmxHVnc3eCs0SlZicW5oalJoTmhBaGtmQ2Q5?=
 =?utf-8?B?SStYUVN6SEV4OXZmRXhEQndZQjVWdndQMGdKQlFGb213U2ExTTIzMjFTNFJ3?=
 =?utf-8?B?b2h5N0ViT29CUnJzL29KdzJ0MkpWMTFrR296QVBmekRoalQyRDFiSTBmMi9q?=
 =?utf-8?B?OWJCWXZaVzdJTVVBQTBZMEJTVFF3NmtLR0hTQkMxak4zQ0RwQ0hqVWhzK1Np?=
 =?utf-8?B?VTRlN1FSVGtQRE5oNDg4cTNqSC9wNno4T0tDcnM5QjZzbnpscmZPdXNvaTlt?=
 =?utf-8?B?bXNRcDBjU2hNa08rTk9TOHg3RUhXZWN1UTEzYVB4dE9wbVBTV09zSjRJVUtr?=
 =?utf-8?B?SmI4N2l2RUVRK3VWZzQwTTZoNG5CWFFZaFJtZXFmSzRRMEZLc3AzZG90djUv?=
 =?utf-8?B?eDlaTGpWdC9YZ3cyaGZPVmlQNm5wRFd4Mk4vZGNkK0dEcGJkdmJvUE9LckZD?=
 =?utf-8?B?ZzZJZGluNXhKYXliVjliNVAxVURxZ3J5ZnNVdVF4Z2pvUWpnNHdoYk9zNXVM?=
 =?utf-8?B?czRBQjdsTE1PUHVuZGU0MEZaejBuLytZblVWOHRqSHMxaFhpZFlCeEtGNjNP?=
 =?utf-8?B?UmNPWm5pd1R5eDM1TTNQSFVZM3VRditKSHBTcjVVcStpcGFvcFJBZExyMEI0?=
 =?utf-8?B?TVlLMkMvS0liVy9nRG9ZcUtGRjgyeU5raXdZaDVHVDlWeGEwZ09XSFhSaGhQ?=
 =?utf-8?B?THVKYWlJV2w3Yi85ZmN6TDFjaUJQSklEOHZXc1NKRThLR0J4cWwwK1dwRS85?=
 =?utf-8?B?TGE5TlhkNlhLcTVMNytHeWgzZGdTRko1Rkp4NXdGaFVSQm9zeG10THpxNTg3?=
 =?utf-8?B?Z1RPQzlXQmNxQk9YaEtOTjVRSndhNkRKNTJhZGZWdm94SWZMc1BWMzhxczRR?=
 =?utf-8?B?QUF6YzJPY0sxVkljV1dwOE5tWWw3S3ViVytpcGxiQ1VxMHVCcXBGbkp1cHNa?=
 =?utf-8?B?NXJwMi9JM04rSGpWYjdZU29jT2VJbVg4OHhVSUlpd3VKdTVHMnZCLy91anRW?=
 =?utf-8?B?ZUxhSG9lS3Y1bUpqbHpJU3l5T2ZZL2U4blM3SzQ4Ti9WbDdjcXNtMUVVR1B3?=
 =?utf-8?B?am5wNStNcVR1UjVRQUsxWDBUM1VaSFB5YU5aNGZyc25LWEtaZVU3MmJZL2dZ?=
 =?utf-8?B?MVhJeHc3b0ZodGNmcGxNeUV2WW52VzlhSzBMZThZVWp5U01WWWppUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cec6304-740a-417e-5e1d-08dee01b2ecb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:40:48.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9vzOasYoZ80nFpdaUfcuDHwyw4q9sA8DgliUK/RxhiiUGCN27wKaFthdj/IxqaTQjxgyKdgFeylJQgoGpNdYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3313

On Sun Jul 12, 2026 at 1:34 PM BST, Alessio Maroni wrote:
> Please disregard this patch.=20
>
> As pointed out by the Sashiko AI review, using `atomic_load` here
> introduces critical alignment issues on 32-bit platforms for ktime_t
> and violates the safety contract regarding concurrent non-atomic stores
> on the C side.
>
> We definitely need a proper `read_once` abstraction in Rust before=20
> handling these cases. Sorry for the noise!

The symptom is correct but your conclusion is wrong. Tearing is not allowed=
 for
hrtimer!

This is already being worked on, though:

https://lore.kernel.org/rust-for-linux/20260303061000.73970-1-tomo@aliasing=
.net/

Best,
Gary

