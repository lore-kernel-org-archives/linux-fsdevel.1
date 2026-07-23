Received: from mta-outp-cfd-2.case.edu (mta-outp-cfd-2.case.edu [129.22.103.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78D45D19D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820320; cv=pass; b=jox/osPA2Ta7aFeCiECPWwPeDlKFziASaL+OFvH+sL97ieUfnlLfkDwg58tmyZX9/c1pbwec9bFnkap6W5w+cstj9McfJ+uGVnnM3XVwtgMz5Ds33Wa5CuB9jimytOte6f3uQYL1frPYBULPQ3ubLVpO/aHq7R56LV/IfZbg1iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820320; c=relaxed/simple;
	bh=8+aighc15BvkODcWSrNWjFd6CGTfRCT3fUT4xN9L3dk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=It1u+/KbHvZaKiJ/r6/x4NgItXrDrFl2rzd7Q16frFZU6dvAwxOvYe/+I/Wh3q0FfvIxP3PuPl9Cw+bd4uVYutWm4fFzG1IQNkkhuJ+gwTEgola9zmkh0cL1oUFw0gZ+ZjViduoBXAZQgeV7zEUj8is1FgZc6BLKxmEWdYzpkvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=VfxC99/B; arc=pass smtp.client-ip=129.22.103.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="VfxC99/B"
ARC-Filter: OpenARC Filter v1.3.0 mta-outp-cfd-2.case.edu 1F8F734803DC
Authentication-Results: mta-outp-cfd-2; arc=none smtp.remote-ip=129.22.103.196
ARC-Seal: i=1; d=case.edu; s=cwru-mta; a=rsa-sha256; cv=none; t=1784819799;
	b=Y/OzA698lJWanRPEHsB25yc6DIA+VM/fDXkJ+DMIRI8X+HY03d62quy/tB4pePd5Jw5M
	 JwLuWdk/4OXLMGR3ZxuTI8jDeW+qqt09b2QSOEm6qArZde5/djBRNRhzgf4nuDkCO8v/5
	 2DiGn2jm28wLRNqaxijaoZvwbIE05uG/vpHoKgCdTqDmyXe36jNAxXXYIQ11ADZYcPesH
	 DDtCLeko8FcKWMibp3+7DnD9z+behMPINCrcBCQx627Gea62Pxutb3Fg0dCz1JRu2ixp1
	 mfWZhZ7fg92Jddh2ueRh3R+4ZZoUS1my44SqUggpycj8no+yiuoKJmo82LZr3PFQUNw==
ARC-Message-Signature: i=1; d=case.edu; s=cwru-mta; a=rsa-sha256;
	c=relaxed/simple; t=1784819799;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature;
	bh=8+aighc15BvkODcWSrNWjFd6CGTfRCT3fUT4xN9L3dk=;
	b=pyW9dc050Tnbu51TAiHL1BvFDBjNRQ4BSPxgNMd+eTeQqJwWPqLA7zHfVqvB/chK6eSx
	 t11UvMb0Augm3lFlV3+tnW0sYd9oH1lJgYuSpfsSXfDz/wc4Kzh1YVZHnfmNNbiUFwmN/
	 XT7DWnSxS1veFxefMMEAUAaS4E3UtyewHEJ+mkZlEz1zXD38l2z57qr6J4mmthO4ocjHI
	 hYB5x+lKV1Whovx/nOPoCxU8xNB6sNdVpyHoKs46syBNLQTWMkhRGPLEcUluilf/pzafD
	 FhD9FDuf2Ng+4wuY3h5D4YV4wXz/N+usoo0JfZktfr7CuDEd+MkpXZecV32hW/lyz0g==
ARC-Authentication-Results: i=1; mta-outp-cfd-2; spf=pass smtp.mailfrom=case.edu;
	dkim=pass header.d=case.edu header.i=None header.s=g-case;
	dmarc=pass header.from=case.edu;
	arc=none smtp.remote-ip=129.22.103.196
Authentication-Results: mta-outp-cfd-2;
       spf=pass (mta-outp-cfd-2.case.edu: domain of case.edu designates 209.85.219.71 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
Received-SPF: Pass (mta-outp-cfd-2.case.edu: domain of case.edu designates 209.85.219.71 as permitted sender) client-ip=209.85.219.71
Received: from mpv-out-cfd-1.case.edu (mpv-out-cfd-1.case.edu [129.22.103.196])
	by mta-outp-cfd-2.case.edu (Postfix) with ESMTPS id 1F8F734803DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:16:39 -0400 (EDT)
Received: from mpv-in-ksl-1.case.edu (EHLO mpv-in-ksl-1.case.edu) ([129.22.103.243])
	by mpv-out-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id EDA54400;
	Thu, 23 Jul 2026 11:16:38 -0400 (EDT)
Received: from mail-qv1-f71.google.com (EHLO mail-qv1-f71.google.com) ([209.85.219.71])
	by mpv-in-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id RXX06698;
	Thu, 23 Jul 2026 11:16:35 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907ca5abf1bso12794036d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1784819795; x=1785424595; darn=vger.kernel.org;
        h=content-type:in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8+aighc15BvkODcWSrNWjFd6CGTfRCT3fUT4xN9L3dk=;
        b=VfxC99/BP8/2nC7pRQypolsHeSBQNZWYAFIL1ViOmIgEg7SH2kXpfpGiNajCtboGEk
         UMiXEfVLW+encZ9OVVuSvdFRtd2U7R29D5mtQ3c+3XjQHtrKRGxiR/nFy6zIsoan7u7z
         dPXJLNFiXUrwGdjkjcnuUWQLaCwsnqLeAYp8OLnYhJxyl71L/k0g+QRV38mvBfTgewmP
         RgcSQ4WrZBefLoknEdagYpXs5/CgHIdifIrwC4Rb6oIFD4JPdojwyoV+HCcipeuCeRMa
         5Pv9SMGBp+PjkDnFk2IOU56977VoQRQV2fH5MXLwdX+koaaSH1L4V7uGy77ojhy38MPq
         yufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819795; x=1785424595;
        h=content-type:in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8+aighc15BvkODcWSrNWjFd6CGTfRCT3fUT4xN9L3dk=;
        b=KQMpO15LjcDEsomWxcLfHCpegEu+GGK/Sptqg6Fp43HaQ7IElP4Nx+gxcIsspZbUG3
         JT1kB6p09Z2nu3mJS5hP7PlBmeXHSohZOF9qdG149IOwpdc+E+g+XfmrF7yfMOhdzeyn
         zq+XZlfeOJ5D8l/NtXIPrAFDQGRl5clIrRyWYCBWfUzvzh2fTsxWjslYCasNcmmAuXL3
         nMCUM3D/K5L6qyXKof5grywIDFxl++j94r8F1+nSrtyZZFuQQcVMu5Hs7Dckys8NQ9ki
         rVgoEC1K7SarMhMtERTUYSaOwo8LN+aQowZcFoVkquafzIj40mOPEEMhdUhZzpjZjGAg
         5vrw==
X-Forwarded-Encrypted: i=1; AHgh+RoF5tGPWTfbwtQjakIpHzv4bmyONs18y86BIW2luhMNWetUgyUXD1veLR2XssMsPLJThSMxj4s2ya19FOBE@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCC97vyxjQbnwuZFBe5xpuQ97/WCQcl7I+VQ+UJ46npLegqZ7
	oGtUeeEdn9IWgA6MoR4psL49o6xSRneWgPvoBNzrOWvVNhismYnTOVF/ybXHibAY0alylKmMeGI
	wdgE1HybS9ifOFelc1niSPOleJ17haWWLxtrFHuZ7DmJJSIV0JZbQyDoDYI0I2tyCUT9/
X-Gm-Gg: AR+sD13ZN4q1iai3Mj8AoHMiCqKOibrab47GNH1UIkSvpmgQdJ993iLw3Ey0youv4u7
	kbPg2gDFIpugsE0E/i8pHBzJWnd+y95qEFar4cz5hqaTymLlhb5ZOBz/RkYvb5SFFN7uNGuXq/n
	jtyK8LVm72V5GSwmsq3keU8wam6C7Akx7sa4m8VlNOJQ+w2EsLkqeIqokZFFzye15enWXbh17T4
	/Q6oj6f8CRJFdS4BBdbrlf7ZTIIPuvxFTG1jOsXExLrIcS2B2ZQ8N6HQIwYQWkJQ/JV07qci+Ee
	Saabcq5k6ySUfDRZOa2oXRg3EZDo1xDCN8HX+T4LbEX6uncSIV1/4x/qZ9Cyzp/BPIjd72K/yYG
	bk0/n9PRJBpVM/NHPiFLH6RpBR+pHHKIgvTHlDY9o4oVrZ4wMzmnkQoNryB8b5+faQJk=
X-Received: by 2002:a05:6214:4199:b0:8fd:6de3:dd7c with SMTP id 6a1803df08f44-907ca8f97a9mr39086336d6.62.1784819794976;
        Thu, 23 Jul 2026 08:16:34 -0700 (PDT)
X-Received: by 2002:a05:6214:4199:b0:8fd:6de3:dd7c with SMTP id 6a1803df08f44-907ca8f97a9mr39085746d6.62.1784819794529;
        Thu, 23 Jul 2026 08:16:34 -0700 (PDT)
Received: from ?IPV6:2603:6010:dc00:1e:1dba:3b93:7cc9:dec8? ([2603:6010:dc00:1e:1dba:3b93:7cc9:dec8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba9004aesm46818876d6.22.2026.07.23.08.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 08:16:33 -0700 (PDT)
Message-ID: <e7575f17-9546-452c-ad08-d908adeb72e5@case.edu>
Date: Thu, 23 Jul 2026 11:16:31 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        Steve French <sfrench@samba.org>, linux-afs@lists.infradead.org,
        openafs-devel@openafs.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Etienne Champetier <champetier.etienne@gmail.com>,
        Cheyenne Wills <cwills@sinenomine.net>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/2] afs, bash: Fix open(O_CREAT) on an extant AFS file
 in a sticky dir
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
References: <20260723140047.702495-1-dhowells@redhat.com>
 <20260723140047.702495-3-dhowells@redhat.com>
From: Chet Ramey <chet.ramey@case.edu>
Autocrypt: addr=chet.ramey@case.edu; keydata=
 xsDiBEEOsGwRBACFa0A1oa71HSZLWxAx0svXzhOZNQZOzqHmSuGOG92jIpQpr8DpvgRh40Yp
 AwdcXb8QG1J5yGAKeevNE1zCFaA725vGSdHUyypHouV0xoWwukYO6qlyyX+2BZU+okBUqoWQ
 koWxiYaCSfzB2Ln7pmdys1fJhcgBKf3VjWCjd2XJTwCgoFJOwyBFJdugjfwjSoRSwDOIMf0D
 /iQKqlWhIO1LGpMrGX0il0/x4zj0NAcSwAk7LaPZbN4UPjn5pqGEHBlf1+xDDQCkAoZ/VqES
 GZragl4VqJfxBr29Ag0UDvNbUbXoxQsARdero1M8GiAIRc50hj7HXFoERwenbNDJL86GPLAQ
 OTGOCa4W2o29nFfFjQrsrrYHzVtyA/9oyKvTeEMJ7NA3VJdWcmn7gOu0FxEmSNhSoV1T4vP2
 1Wf7f5niCCRKQLNyUy0wEApQi4tSysdz+AbgAc0b/bHYVzIf2uO2lIEZQNNt+3g2bmXgloWm
 W5fsm/di50Gm1l1Na63d3RZ00SeFQos6WEwLUHEB0yp6KXluXLLIZitEJM0wQ2hldCBSYW1l
 eSAoQ2FzZSBzdGFuZGFyZCkgPGNoZXQucmFtZXlAY2FzZS5lZHU+wl8EExECAB8FAkPi19EC
 GwMHCwkIBwMCAQMVAgMDFgIBAh4BAheAAAoJELtYafBk6nSrelkAn31Gsuib7GcCZHbv5L5t
 VKYR9LklAJ4hzUHKA49Z0QXR+qCb80osIcmPSc7ATQRBDrBvEAQAkK6TAOKBEM+EC4j6V/7o
 /riVZqcgU5cid2qG9TXdwNtD9a3kvA/ObZBO93sX59wc6Bnwo4VJxsOmMlpGrAjJsxNwg3QH
 akEtf8LXRbVpj5xStdmBdQZUhIQyalo/2/TZq5OijtddUQcL5cs70hTv/FpT3wUvr2Xr8rjF
 41IFEz8AAwcD/A0CZEGlzIrT5WCBnl6xBog/8vKiUCbarByat3d1mL6DbizvKNXQRTC9E/vE
 dENAWCQCjr75Bu55xT8n3SXGtWdDC5xmZ/P3OBYORP8yl8H8I1FIosWOFirbIeYdZPq8SPD1
 HL+EXo9zSiHVrrZRJ19ooCKKbSdXHFCY+aJG+0KZwkkEGBECAAkFAkEOsG8CGwwACgkQu1hp
 8GTqdKvjcACfZlkVCDwaz/NTO9cy3t69oWpVPNwAnRwe0qk/WL/gfhH346xh5B3HFbFN
Organization: ITS, Case Western Reserve University
In-Reply-To: <20260723140047.702495-3-dhowells@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CxlVvhftc5dxjbET27xndGG5"
X-Mirapoint-Received-SPF: 209.85.219.71 mail-qv1-f71.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.243 mpv-in-ksl-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-cfd-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A2D030E.6A623057.0016,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CxlVvhftc5dxjbET27xndGG5
Content-Type: multipart/mixed; boundary="------------SH99zPIpueenVUjGfvttoHtT";
 protected-headers="v1"
From: Chet Ramey <chet.ramey@case.edu>
Reply-To: chet.ramey@case.edu
To: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <christian@brauner.io>
Cc: chet.ramey@case.edu, Marc Dionne <marc.dionne@auristor.com>,
 Jeffrey Altman <jaltman@auristor.com>, Steve French <sfrench@samba.org>,
 linux-afs@lists.infradead.org, openafs-devel@openafs.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Etienne Champetier <champetier.etienne@gmail.com>,
 Cheyenne Wills <cwills@sinenomine.net>,
 Christian Brauner <brauner@kernel.org>
Message-ID: <e7575f17-9546-452c-ad08-d908adeb72e5@case.edu>
Subject: Re: [PATCH v2 2/2] afs, bash: Fix open(O_CREAT) on an extant AFS file
 in a sticky dir
References: <20260723140047.702495-1-dhowells@redhat.com>
 <20260723140047.702495-3-dhowells@redhat.com>
In-Reply-To: <20260723140047.702495-3-dhowells@redhat.com>

--------------SH99zPIpueenVUjGfvttoHtT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8yMy8yNiAxMDowMCBBTSwgRGF2aWQgSG93ZWxscyB3cm90ZToNCg0KPiBBcyBhIHJl
c3VsdCB0aGUgQmFzaCBmYWxsYmFjayBsb2dpYyBtYXNrcyBhbiBpbmNvbXBhdGliaWxpdHkg
YmV0d2VlbiB0aGUNCj4gb3duZXJzaGlwIGNoZWNrcyBwZXJmb3JtZWQgYnkgbWF5X2NyZWF0
ZV9pbl9zdGlja3koKSBhbmQgbmV0d29yaw0KPiBmaWxlc3lzdGVtcyBzdWNoIGFzIEFGUyB3
aGVyZSB0aGUgdWlkIG5hbWVzcGFjZSBpcyBkaXNqb2ludCBmcm9tIHRoZSB1aWQNCj4gbmFt
ZXNwYWNlIG9mIHRoZSBsb2NhbCBzeXN0ZW0uDQo+IA0KPiBIb3dldmVyLCB0aGUgYmFzaCB3
b3JrIGFyb3VuZCBpcyBnb2luZyB0byBiZSByZW1vdmVkWzJdLg0KDQpUaGlzIHdhcyByZW1v
dmVkIGluIGJhc2gtNS4zLCB0aGUgY3VycmVudCB2ZXJzaW9uLiBUaGF0IG1heSBub3QgbWFr
ZSBhcyBiaWcNCmEgZGlmZmVyZW5jZSBhcyB5b3UgdGhpbmsgLS0gc29tZSBMaW51eCBkaXN0
cmlidXRpb25zIHN0aWxsIHNoaXAgd2l0aA0KYmFzaC00LjIgLS0gYnV0IGl0IHdpbGwgYmVj
b21lIG1vcmUgY29tbW9uIG92ZXIgdGltZS4NCg0KLS0gDQpgYFRoZSBseWYgc28gc2hvcnQs
IHRoZSBjcmFmdCBzbyBsb25nIHRvIGxlcm5lLicnIC0gQ2hhdWNlcg0KCQkgYGBBcnMgbG9u
Z2EsIHZpdGEgYnJldmlzJycgLSBIaXBwb2NyYXRlcw0KQ2hldCBSYW1leSwgVVRlY2gsIENX
UlUgICAgY2hldEBjYXNlLmVkdSAgICBodHRwOi8vdGlzd3d3LmN3cnUuZWR1L35jaGV0Lw0K


--------------SH99zPIpueenVUjGfvttoHtT--

--------------CxlVvhftc5dxjbET27xndGG5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQR8ATX7CIqvbGbGULm7WGnwZOp0qwUCamIwTwUDAAAAAAAKCRC7WGnwZOp0q1ts
AJ9lHbB9KorRuGnv0zbi+/1FDyDO0QCeP0Ag7LXnUSG187Zn6EvbIxMvRsA=
=Q4MK
-----END PGP SIGNATURE-----

--------------CxlVvhftc5dxjbET27xndGG5--
