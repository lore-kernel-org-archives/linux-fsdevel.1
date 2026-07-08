Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505653F12D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531347; cv=none; b=Wm+t5iQ4jqxKXdxiwGYiAQXfd6aw4SgfWPViIrLkezWyc1TV4krAEmpi1PRQ386yuucG4wg8YL2hSwm0CwFKC9MoL9PFHmaq1kuUTQfCVRfHBZZwSgORfaAHlbKQt6jy5q1uDZWTa5sZiJ5PLFOrdpCP8+GXopkYZF13UhzKxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531347; c=relaxed/simple;
	bh=lMIL/473WJlnmg38PJMkdqZsr1WoymuBqYOCyK6JhIk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ps0PJaPxGETcvATbDJ7GHuK2YoKT79xq0iM5NPlGPwPT+V2rlceeV0TUYTFQppksQP2ovML4NDmElUUymChZwsnz1AVDUyic71xNleZZblRfrgQmvVV96HfH+0yO1Da78hI5/kwEcxOVOLujLo8+TduZ3hQYkoe4Mzm7Mzi9nGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZtXG59V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=moxpthSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZtXG59V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="moxpthSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783531345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMIL/473WJlnmg38PJMkdqZsr1WoymuBqYOCyK6JhIk=;
	b=YZtXG59VDJGmM0xam7EuoJcw4Ml3RiAKCH9t2ez2MEZ2dRnPXho2BG3VWWyf4XnS/VOt11
	rPGQ4D8v4oj/A3ZeRb4tAHdvhL+ijwSxe8hQZYuUDRBIpgl7r5PPK13lXWbeRksEuC07Oz
	sQ8vJ1Kxm7OFkmAefaXvUWQkyFKKYf0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-CXIe96n4Ntqo8Op2iwNlyQ-1; Wed, 08 Jul 2026 13:22:24 -0400
X-MC-Unique: CXIe96n4Ntqo8Op2iwNlyQ-1
X-Mimecast-MFC-AGG-ID: CXIe96n4Ntqo8Op2iwNlyQ_1783531343
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-80d927cee77so19620547b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783531343; x=1784136143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lMIL/473WJlnmg38PJMkdqZsr1WoymuBqYOCyK6JhIk=;
        b=moxpthSPhuUP7RyPHrobE4JOlxHJREaeuvZ5vGCDvD1VWo7v0MxR7rxqhvNNQhHGQw
         a5A2yIqkx4n5gRpeZPMN9pU/5WguGMC7KD4JMyv0eUVIXu2sGV+TNqSFNj5f3BjT2NFJ
         Y9PZLP/aRBuRJyQM/lmt/qZL7uy9cRohRKH+m0owNFK0cN5fw/9PF+x+ntfhUXXDow2x
         nvjiYq1/Tm77rEz2MzwC32PGc8zE1uWyERpIJ26z1jmxiFOuv7imDbUgSGP3wupdWy6C
         JG+ReDx8TxubZQ2WLUS6iwPfDP6TUH6xS4SRECp91DMgYCJ6ROoBHGw//jQjDg4kOuOo
         X/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783531343; x=1784136143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMIL/473WJlnmg38PJMkdqZsr1WoymuBqYOCyK6JhIk=;
        b=NgQd/1K8GDJPPSVgEScDuUMXq0G5nedHoYuDZedzzPLoHcKYogHCm+XHtoHxP0XJ7Z
         AVEz4bP3coJve6aPcBoX3/3eQ7qrIXpb8sqJiCACNe1IJ0eYlzM/c7vcQq1QyNFNTTU5
         1A+RKiBXLyPIYHMYE3lKo86FKa3Ap1znkiPR+rHNdgmZUqMQsfgmcJBcmv5W3yhFBcVS
         VoYUAB7Wd8Skt2k1x4Po2vC01fxiXDS3xEH5bccQyEPFVw4ya7zPXldsZDnGwcTqYbrw
         orPueepUtnJtPtowSc6yYEwRoGiXGSyeu8AXnyOAYUi1/PDNN4rT2yEf/QmNcppQSthK
         9O3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq+q3TyVL7UZFbhyCtZhZ2KDL84WRHqLuceln29GQdHlUvHr0BdEDrBZATzK4Y8aUWlMMCEzt1nRETR2aG1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cQVnqJMd8EZuc4RO4kMIVmef36CUkBA1QHeKF6rodWdwww4m
	zNNd2JZNFHpPF4wgodAH9cs/xMxWTcz6FchabomIw73WWvwE3yGOxtb0/Tj7tOEDT5i+iHIq18Z
	99mXK9FA8d/N2pt0xVrk+KgjCxyTMlpxAFHHYIyNzS4DfSIdv8Bdcl4dHluoMh/pujVM=
X-Gm-Gg: AfdE7clZI1ciulCQTLRfwMl7pHlzERULcezahWYT5te8iUu0zbXr0m1wP/QZ3CuBn2j
	q39uWwOzKJv7rpJUdjK9RzPZglQbPDdv8ZrJPRv6Di83hKs2hUGubrCn+h1NLW8TfH6Kf282jrg
	f4m3MWuAnVCRWOH6BH0AtvubSdiIDwdDxzzyk+gr4T2r42IDQVuSSkNuePD36lfNjkfPdHHKk0F
	5BCbaWLy5N710xXZzmueZll4oTup9DtWRs5gGA2H/K+d2I4vYT17Xl6uxXqhJM6wF4GSLY0jTeA
	AU401MiOhOk3tsV+dJTyJ45O6MdmMw41RMSz+PIi4dn0iOgEkAqO7dJi7au9xOFbmhN3ShSmsuY
	LgMmbtwqNzEWHruX/qDtvsFp/P+NcN4Iqm2fcgm7tug==
X-Received: by 2002:a05:690c:4b90:b0:80c:9983:5e5f with SMTP id 00721157ae682-81dbee633c3mr24687167b3.31.1783531343456;
        Wed, 08 Jul 2026 10:22:23 -0700 (PDT)
X-Received: by 2002:a05:690c:4b90:b0:80c:9983:5e5f with SMTP id 00721157ae682-81dbee633c3mr24687007b3.31.1783531343054;
        Wed, 08 Jul 2026 10:22:23 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448219e6bsm83860397b3.18.2026.07.08.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:22:22 -0700 (PDT)
Message-ID: <1661b736aae40d68e93e7fcde6c183848bdb38b9.camel@redhat.com>
Subject: Re: [Linux Kernel Bug] INFO: task hung in hfsplus_commit_superblock
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Jiaming Zhang <r772577952@gmail.com>, frank.li@vivo.com, 
	glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
 slava@dubeyko.com
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Date: Wed, 08 Jul 2026 10:22:20 -0700
In-Reply-To: <CANypQFZTwjuh75s7dGm5nUXQ=1ko=cSS5AKEZpszbxyQo8w93Q@mail.gmail.com>
References: 
	<CANypQFZTwjuh75s7dGm5nUXQ=1ko=cSS5AKEZpszbxyQo8w93Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 01:01 +0800, Jiaming Zhang wrote:
>=20

<skipped>

>=20
> The v2 patch has been on the list for about a week. When you have
> time, could you please take a look and let me know whether any changes
> are needed?
>=20

Could you please do not multiple number of reports by lengthy email? If you
would like to ping me, then, please, please, please, ask question in the pr=
oper
patch's thread. This email is really confusing and stealing my time instead=
 of
reviewing your patch.

Thanks,
Slava.

