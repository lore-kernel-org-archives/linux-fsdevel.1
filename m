Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022141.outbound.protection.outlook.com [52.101.96.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1F3F4DFD;
	Tue, 29 Sep 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706156; cv=fail; b=uoyIftOPLO3D0Y5m+XSqW+WPCSDV+tzDxJv4pfHsLBfA6tiasN0YDuN2rH/YbyRiwdLI2MANmvQC/Pr3Zfvd0yaS31cjP3QvI5WDC+TnxxHNZJFd1AeLFfToV9ffZGs5hYwen97BRgVuPvDU9sZ0usjIuu/TqXggcaJr0FAfXG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706156; c=relaxed/simple;
	bh=59tzm676w1BblGkzyFM/oipojvXuXJYeJjRs2fnDiyo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=iHKGJxADifdGhk9LO0yr23hXx7fi797RT3Tquc28iAGEaEKCVBq8Z0y/+VPFhtOao8zOb1/UJQgHN21uii+CNSYO/Y8VvoL4KzXqy4TmDb5UvbGjk7Hwn97ZC45h+eq849bcpejmk9P0ju2gC8gTz5ibDnaDnOI13ZFHi0GcqyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=o6A2P3U0; arc=fail smtp.client-ip=52.101.96.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="o6A2P3U0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsUCxyUPtYlgJ+9CaChsczpcsUrQZ88SBimMkcPaCDL8uaL4KSAyVpqs6xCCEcYZuQv1NR3i29gINGq51DveuAymgGxZ1IkC4YmuBLoLE4e+uR7ntZ1YqmEUuHdTd/Iz3sVaGiIEnT0T57dLblMZ+AIiSFGQiTUeo0oM+0M82R1MeesTWQoqcdQqZQO/EXY5FJmeIimvgcXA+ectTKh+EFNAkFfbcUJRopnaB/13DWIe+XNCF6TnbU1/N0AhkDNto9ewFFLcWK0PPrenuTlohnwBT8tDuIWQp8UWjUVv169FvhbcLFm7cugfPvo9EMWr6ISEIePlBDhNM2LiXJgOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKWxIWLJlUKGYnOfeeqI0Zpx9QjvEE+OeuXYII3uI/k=;
 b=PSV8anacKh085/qu9qfZAdF6yW+S08eHpK5d60nRNG7HUIwYAQE8XsYGvhm7Ro3pULyjXEJe2SYBZkpyg3RaPHwza+WNDc1q2HfEnR+ojzwobnz61TyzJx/FoyZoR0pUBQgte3rId4BX5hoF0RDE1zTsT2LPlM/bNIHo1L3WghjfEwbiSUp+G9oVD67LaRiPomv/CLlVGp/UysSSa6S3iLwwpIdhF6C95qVt/kG0hEfYuvnufjeSFro1ShmlMG4y+mzBllkwaKTnW0HYkZ5r9Y6i8Cno2q+3ayjJ3vO2M47n/abq7bKALxxj2wGYCJmEcAC30uFcaRScWd8AP9IcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKWxIWLJlUKGYnOfeeqI0Zpx9QjvEE+OeuXYII3uI/k=;
 b=o6A2P3U0uEKgcn6P5pULNklp0bj2eMTGpVCDcubY3nr9l2CgAUvvj1l2Ts1smlqd3hVmiZKgG/KiGHcmv97FVPiWk2VAMLRFt0JvRyPvQA6RSljvsq77Zqq99EcVnJW1sPWCDIziEnGcEzxJvCs+ubLl0e2NYpLKsb2BTyWZZSs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5178.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 18:22:30 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 18:22:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 19:22:28 +0100
Message-Id: <DLS0CO1HEGJN.2XX8QX8LW8XJM@garyguo.net>
Cc: "Christian Brauner" <brauner@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Georgios Androutsopoulos"
 <georgeandrout13@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-fsdevel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
From: "Gary Guo" <gary@garyguo.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV> <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
 <20260929135154.GB989762@ZenIV> <DLRXHGLDR2QQ.WZVRWGY995BT@garyguo.net>
 <20260929170218.GD989762@ZenIV>
In-Reply-To: <20260929170218.GD989762@ZenIV>
X-ClientProxiedBy: LO4P123CA0301.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: e769b40f-f41f-4b2a-1455-08df1e569f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bjs1POFsjNloBqouBf9coijdnMwCJZgbPiR06GY5JKPKO8xYo+X5WaieycMfsPGVmUvdhby+iQHCoX59y/7z1vZUrFPqDUlS5Evn1yNSjfJe3K2qCBYNaLWcCufCyqvmIssbTZ/WfDIpuwCZ+IIK0zjUv3d2VHga8UnKK0+IloHK0hcvubo8PWCaw491pcVPeqsFQxsnl0p7mSd7DEVTN9bDlDF5B0galldeDim9KiGwalhSRM6nOT/z9j4yJcBcEYCy9IsCK9Bi24zd78jFbDTBh6nL5xI3cwZ2eOFzMJFQpeSWvxvVTdQYUze8bjCB9Elwg9G4cC9B4cJ9vemeZ/UIl03wbcFNL8f0bNB8kYM8bYWY3OClDCq643V9+jl+yjHsEodf7JS70UxTiuu/hw2k/6YhXAZpFPokV6IGIVD0AT8+Ee65q60cZlQaJC9U4Sc1co/ioQQcLauM2AC/xFxz6qr1MbAqXKFEmSuDxDFWR2+0QndylbekaAWz4P578LkNQX00Tajz1GvTlX9bf2g3HMyfrO5af7l+P/8Bfpj1cDCh4nJMucxbP2/OEKXlmuV47kiUORwhz9+6o+Rqy53yf58clGScruc5qYWSUy4zO3czJKcLhUwnad6t06NoQJt+88SdYzUfH31dTJ/WRdhi/KsZ3cG8Ks+S78tvsx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVg5T1J0NlZKODdRdEluSVhPQ2NGTnhSOVo0QTZHTmFKVW5RdFVrcjR2SVpQ?=
 =?utf-8?B?NUhtODg3MjA1YUVCSUUrbWtkUmJXdG5GblpkdmFCVDVwbUVzdThPOTlMNWFI?=
 =?utf-8?B?aW4wM1JWU2dLaDM2MTBGc0NJamZZZTdlYVZIYWVuRXdSckdLaEkzSlR2alk1?=
 =?utf-8?B?YUxhTGluZ1lGT3VISjJsNDk1WjJVK2xOV3NvMG1uZDlPWkVSUzhLK3QyUWhP?=
 =?utf-8?B?SFBVQlVaMnk1WjNVL1NkQkVEdWR1dDBBWVRPQ21KaEt5TnVQZFRQcC9IYTAw?=
 =?utf-8?B?Rm9CanQ5OEJ3MDFwUHpUaGZ4Zi90dFYyVGJzSllMR0RNQnh3NEgrSGZ6Qys0?=
 =?utf-8?B?TjdZNTlVT1lSY25LRVU4ZXVkQStwN0xLVHduN1F3STdUN2JVNTU0enYxR3py?=
 =?utf-8?B?WUZRYXpBemlBOFZCRVN0LzgveVlrTEE1Q2VEbkpHWU1xWU8ya3MrQ2ZJRUxs?=
 =?utf-8?B?cmMvUm1pUXpDbEpEUHUrVjYySWNmN1Nmc1ExY1ROaXdma1Nha1lFTi94U2Fx?=
 =?utf-8?B?Sm5kdVBGVEZFS3A1K29IZTU0VEdqQ3B3VmhxbU4yRWNnWHNyVVR1cERtaHV6?=
 =?utf-8?B?M21hYzBWTS9RMWNFNEZjdU4zTjNVUmN2VlJhNkZxaU5xZE5MRGplQ3Q3UWFN?=
 =?utf-8?B?dEEwSEp1cVJRNVQwK0VEai9DUFUzczJPVkFmZFlzZ1dGRytLK3pLdGsycklx?=
 =?utf-8?B?eGRERU1IREtjZFFOVU1KVG16MTJidVFNK3hVV01NbGlaR1NWbEhibTN1aG91?=
 =?utf-8?B?Mlg5ZHlmemp5S2EzdjJKSzNHbERlWWFYMS90OGNGdkdGakRFalo1NGN4L0xq?=
 =?utf-8?B?VUpHcDlhYVdkMmdUbU5PanQzbUR3Z21LQi9hZEN0MFdSQUNKc3JhOG9iU1Nl?=
 =?utf-8?B?enkwRGlrSEc4RTVLcitIK1NWeU40K0tWVzB0TWtuQVhCL2ppUTFQMkgwTzQz?=
 =?utf-8?B?YWdONjlzTmRKT0hEQ1puY09RN0x0RGo2Njl0QVZjTUZiYVYyZnFOY1dlRlVI?=
 =?utf-8?B?bXBDclBocFNCY2dibFpPdDI2ZDVYWElBYy9hUVdmSWk3NEppVldUNUFOOUhY?=
 =?utf-8?B?cEEyS0tiN0lMRm9SZ0t4QkxIQW1FNjI3MkZXRGxqa0hCeFVvNktRNU5XelU4?=
 =?utf-8?B?eDM2akVuUkFDcEwyTWRoTWh5aEdXeXZoNmpzTnlNMDZoejZneUJESU9NQndn?=
 =?utf-8?B?ZzUxN2pSNW9EWkVvQlpvNVRRZWoyTmRJekVYWUlTeEJnWDNkNUozekNYOWlJ?=
 =?utf-8?B?ck45UWlBY28yazZwN09vK3oyZ0Q3N0tmYmUzZTVONjNxYUxIV2lWcUJ6K09E?=
 =?utf-8?B?TURrNzUrZ1poQ1NpZ29LNHBoU1JhT2xNNDVwK2FPWG14aFZQTWU3SFArRjVN?=
 =?utf-8?B?aFgwYUpNZHhuMmM5aEZLY0NoZFJDZTA0R2h4RnZFOVc4clRUOGhFRHRrd3pM?=
 =?utf-8?B?K213Q2RNbThmeVI4NTBWcm9VVjh6cXJhZGtDRzFBM05RVnErR0FONGZkaDV2?=
 =?utf-8?B?OG1pYXlHZ0JSTW1UQzhxYmFXcFUvQk1lRGdtdnFiMHVRUzFRUThZQmFGR0RG?=
 =?utf-8?B?VHRMYWpHM0ZzVitGWEtIUVJoZTdkaDE5L0tTRjRjNnlmZkhSbnY3a2M1TlMr?=
 =?utf-8?B?WTZqUmNDUlRJSXRqdEJlRURWMEJiSmV5VUtXMnpkd0VKSUxiUDhyaTNXamFl?=
 =?utf-8?B?RDE1c2Z6REk2QWtEdWZ2bzVZdlhCTDBTVFBUb0dkUTNNQXdwcGk0bVQ1bnZr?=
 =?utf-8?B?RGZ0VEJ2UWFzaXROU0FPWmV5S1FFallvUEZxV3JpOGJITjg0bk41endYUUlK?=
 =?utf-8?B?U3J6MDVlWEh1dmsyTEd5WUZEWW1JMjNKMzM2Qk1PZkNYMEFYSWxUTEhhK0Nv?=
 =?utf-8?B?a0dtYkhzelZ5NnlhcFFLN2JLNnZ5RzlHSzhkR1laaGM0R3J2RjRTckRKT0do?=
 =?utf-8?B?cWJyaXZaa3krTExNZi8zblNBMUNxUFFrbUQ1V3dDajRuV1lUWWMvYUdqNkQx?=
 =?utf-8?B?SFNCRFl0aE9RUDNnMGNrRFkxUFJxQUtpYzZsZ0xkbWhObFZBQ0NSQ21sTHpO?=
 =?utf-8?B?RHUvdG1RSTlOQVIyY3BrSFV6L1FTaTNLQ3BBNjNVN1VtRGZKblVIR3VMd1FL?=
 =?utf-8?B?ZVdTR1VyZXZPakxhRks3UU9PcFlKbjJKaWs1VE12L2I1NkhOaVBZanpwTm9n?=
 =?utf-8?B?ckcwaU1DWmxqRmdMWHBJUFphbjRQNHZPVFRqaHA1OGRDbXBoNUdLdmx0ZGVV?=
 =?utf-8?B?SlVKTFFMOXNwWU9lWUdNZUNDMGJSem5JQXRGUGQ5TG9BbUFMSTFzL21hdE1t?=
 =?utf-8?Q?pxXuXOiVX9ec4dZYOW?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e769b40f-f41f-4b2a-1455-08df1e569f45
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:22:29.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7BAPtniIiWOjmtGnUEvgD6RLTI0+l/QPui3BbQxSoSTllcIaQd/0s8QTnNLnxpgBKgaXGRYoOPNNQ5DVFHqkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5178

On Tue Sep 29, 2026 at 6:02 PM BST, Al Viro wrote:
> On Tue, Sep 29, 2026 at 05:07:40PM +0100, Gary Guo wrote:
>
>> The reproducer that Georgios posted on GitHub is some cleanup job being =
added to
>> task_work, which drops FileDescriptorReservation. And since exit_task_wo=
rk()
>> happens after exit_files(), put_unused_fd in that cleanup observe that
>> current->files is NULL.
>>
>> So it's not from random thread, it's from the current task. And I find t=
hat
>> particular case of doing per-task cleanup not unrealistic.
>
> FWIW, descriptor reservation ought to be tied to specific files_struct
> instance; note that dup_fd() can be called when there are outstanding
> reservations and the copy does *NOT* have those reserved.
>
> What rules would you suggest for such delayed put_unused_fd() wrt e.g.
> files_struct unsharing?

Ah, is this about `unshare(CLONE_FILES)`? For that case indeed our existing
abstraction break down.

So put_unused_fd must be called in the same syscall context as
get_unused_fd_flags.. I think we can address this by give it a lifetime
parameter

    struct FileDescriptorReservation<'a>(..);

and require `current!()` to be passed in:

    impl<'a> FileDescriptorReservation<'a> {
        pub fn get_unused_fd_flags(_current: &'a CurrentTask, flags: u32);
    }

    // User
    FileDescriptorReservation::get_unused_fd_flags(current!(), flags)

I checked binder I think its current use can work with this, although it ne=
eds
some changes to pass this `&CurrentTask` token in.

Best,
Gary

