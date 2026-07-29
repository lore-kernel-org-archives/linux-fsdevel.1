Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80F494A04
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335292; cv=none; b=azbkh1V5/QuEp3FSKG+5kJurI7SIfGAqFzGUuLjVEwqsRnyBYhOExWqJRIf30lwP46BKKW1GvkEH7qlxmdukBIr4hMwOcpUxxHoMjVsq1O5bPCJZxEXIBVIk4585iXxPpZP6/kfS731kh/xv9vW7hsi42WqCOyXsFZd/IyPJmsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335292; c=relaxed/simple;
	bh=+ErPDlVZblZibFShKcxn5UgTNOCXIxQNPxLF9T8ZPtM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PQeq0yFF/7plVv4Jedec4afDbEb0DXFbRc1ZzyNUVFYD+cfHJCXPehjaqBFh4DJ2WJ6HhetMsfhVRewNt7TJAutZvx6hD+ed772qEWG8KQqcd0mt7JNJsw80hewDoRds471WVmUrjKIpIqD4RhWubeQDCq+MyMN9IxEO30IRHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm1IYhYf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOdzqYrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm1IYhYf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOdzqYrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785335289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EGak2HM83KvOa4m0yEIRICa7eaSA5C6mu7yl+7kc2TU=;
	b=gm1IYhYfv7asJg/Zceu9QOq6JodjJsNr6wFzfGwdbPCDBfQQWW0B+z3re4mHd2lydX2T6s
	de2s4cvDCesrbmTo/S/An4ueWlklIfJzapF3wUcxsJfkQZtadW3vUqFmo+Xm4bJpjz9cKj
	FGkVHrd9dIFoAuKMr9jBYH5UkEh1PGY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-SMbSQZc5PGaPtgVHnELttg-1; Wed, 29 Jul 2026 10:28:08 -0400
X-MC-Unique: SMbSQZc5PGaPtgVHnELttg-1
X-Mimecast-MFC-AGG-ID: SMbSQZc5PGaPtgVHnELttg_1785335287
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1c25c44d15so124457266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785335287; x=1785940087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EGak2HM83KvOa4m0yEIRICa7eaSA5C6mu7yl+7kc2TU=;
        b=QOdzqYrvcBDZItcawKA2gXEbi3xur3wWOcHJpcxJx91boXxW1haR3V1TCZAtZC++No
         VWW5DFxP4Q2I7UePksigdle4PIHfMqRea0uDkJsONXBwkIE8ByZHRJscgRRfwikUyDoh
         e95wrDLMg6Lh3LznTjt3E1Dee9kZlIVyjhNVO4Di/4a/7ZcCNssBbNGYzRzxVAcBO+vi
         wUIBwZKDQMZYclx9aPBzWurFfy0k13gzz7rptAa93arjYAljXv/jXINdodwOsYI+VmKw
         Q35Q1i/HzUiR//Aw4oPtV2OOXlJupqdXah+vMY928RtCJQJsO49spVzAnummBzfkaj8l
         Og/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335287; x=1785940087;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGak2HM83KvOa4m0yEIRICa7eaSA5C6mu7yl+7kc2TU=;
        b=rcUEv4pI9uWSRrQMCr71xeJI4TrjU+/91M2CtSvVkojEokKOI1mkYEQAW61XqHlnVE
         b8p8dn+iY2bDibrZPLnsIdbWZsJ4JCjGtO/jM4JBUAPswqxahnUcl2eyRi2U9TiMLbeU
         jmsgITYbGMEWUEacAXAavXG6q5qlWZ222izpvSqedzT2haf1rM4k0H0Z5Xo4W+eQ5gIw
         Fb7WY2a60vh1bEzvLBFPrqRVprZy1Hzf2NZa1z39iTHL2d5zu4xf/zYZqeFOszWM53Ha
         KL67sAv/4MSYSzULhcjwJ/JZ58tmSYrDjY/ty280kf2tvOq8JoNc5XpThmfO0pKbV5C6
         ymPQ==
X-Gm-Message-State: AOJu0YzAgyxs4v/O9V/u4rMD9BidOwnAdex+73bn3WELbT1CBo06fuFM
	qp99fdWcG8htZAE6IE5HsxqclVI/xTSZu7XBaBjmHpWbYdBksFRRmrc1xfwF6QfVlQ/+90xAzSa
	Z0y0/KvLFAocSwwlnHEWt6NCuBpfE4ZFuP29q1dh2cUSaX8lTZnRCLVHUanLsBTySILc=
X-Gm-Gg: AR+sD10X7D+ufkNpdVmA2BwAZyadOFtXgcOv3Fok9fXXhFBGZDq24vI3q+xiunqQldd
	BgDvZsOXUqnaxrKStwPMsL9HG9Dhh6n8BaN14ASOwOjIjB/TPPn1tfiSC/DXdMtEC4oqZRlGzem
	coJkWLVVC29J2Ma3yvErA/Xdc1yb77o/6d6h7fqVHNiZLCXpDQX5zJ79thMxWVKI/55H1mqBaM4
	4S9lPXw/9JckLmJPsuoYpZHPfufjNMSCH06hociL/9zTHuvqEPYTG/2uAJ2uWo/CQqMNPN0BzIq
	GUTrWdv7GvndIETUxEpi1XIUMY1tQh6yrNbdN/JALAV89UJmOtdi+nytEnG3h/3lJDlULEYrK7z
	u
X-Received: by 2002:a17:906:f583:b0:c12:1651:17b2 with SMTP id a640c23a62f3a-c1f71e900c0mr379746366b.9.1785335286778;
        Wed, 29 Jul 2026 07:28:06 -0700 (PDT)
X-Received: by 2002:a17:906:f583:b0:c12:1651:17b2 with SMTP id a640c23a62f3a-c1f71e900c0mr379744266b.9.1785335286365;
        Wed, 29 Jul 2026 07:28:06 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c49f7dsm957349a12.18.2026.07.29.07.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 07:28:05 -0700 (PDT)
Message-ID: <dc0f6f41-84be-4a70-92db-89890bded3ab@redhat.com>
Date: Wed, 29 Jul 2026 10:28:04 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.9.2 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a fairly large release...

A number of memory leaks fixed (from AI)
A number of netlinks fixes/enhances
A number of exportfs fixes/enhances
A new nfs-iostat option
A number of gcc/warnings fixes

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.2/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.9.2

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.2/2.9.2-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/2.9.2/2.9.2-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

