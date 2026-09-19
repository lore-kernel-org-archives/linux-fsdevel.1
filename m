Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890037A49D
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832412; cv=none; b=J9ydrn9yJqJNebcRkSDht4PqHGzpbnCa8eEoMNbMrANNvTQdCzxdIDI/kUaDTb8wg+KR4hwxlFWBkCm1IVt4MYb/HmuREPn28rhrUqMY5rJfZzsFaiBLDyNrBrg/qY3B0F4sxraZ1vbybSoYc9/I9XjATub3aVJM2Wy+UJ4IC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832412; c=relaxed/simple;
	bh=Y4aLsO7E5K1rlKqvYJbr/U4BDZy6IH6PStNFk6QKzPw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kHLQL2qSG2mtKBvGdT3tO9TkYHOe+XfKUbfEOQU9g3NK8yHJ+tMtwzRIOiMzR/lZVcKeQYyjsg46RkqWnjgP1oantQOVd02Q4hWHymC6npO6z8VWcVYVAXK+gFIcCJqkCMZ9Pyasb/4iMDBIGiU58Uvm5c6zZ1IBq8aqthIK/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4+Z9AFr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t0qZlavM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4+Z9AFr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t0qZlavM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789832408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=13X+p5BlHvU1jlJef4qxKfLhScGAMJVOYykK2pEOeDw=;
	b=N4+Z9AFrTD2xjFrcBdxVHalKE51g3TSdkVbr5W40CWFQYAsL8dm9WuOTxFRVuWt5sAWhVS
	xgaftODe+mw4LjC18fsE5j+ZMUm88dpL4Uj5+NfTyYxwLfBA3U6rZQE2UCTx9qLAzIGeV8
	VYQXdP2XFrXs2fzzKjH1Fs6kOUSxn7U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ExJgUJJjN3Gpk-WE0qavmw-1; Sat, 19 Sep 2026 11:40:06 -0400
X-MC-Unique: ExJgUJJjN3Gpk-WE0qavmw-1
X-Mimecast-MFC-AGG-ID: ExJgUJJjN3Gpk-WE0qavmw_1789832406
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939a6937513so257908785a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789832406; x=1790437206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=13X+p5BlHvU1jlJef4qxKfLhScGAMJVOYykK2pEOeDw=;
        b=t0qZlavM6jModQLtcyTRGNUAWzOmXrx9sTODu0BdJTVsqJ+Qagt7ObKKVH4m7y4nzt
         YroQTFtuiGT0rcBZsQR1sBccOY7vtLScsfPhY+Q3UE07g9rTcAJypF+Qa/oyiDlGGKcU
         DjobItQRQoNQIDXRous2qGIMGAL68rlomPmsyzM/abZ5namfZTva16c9dlnxJ5fndtkq
         1VrI+Q4Ff9+yz3cQrmu7BFRoImcWC0o2xuTuGT73nsesbrGUiAoh1cgv18zlRaKJp4GC
         V29LZdaF7W+VzegUXlwNsPgjB7ggpJDfcSWrNFEHtv/JTQ+i7m9VH212zan83CztXzHG
         AC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832406; x=1790437206;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13X+p5BlHvU1jlJef4qxKfLhScGAMJVOYykK2pEOeDw=;
        b=16xazAv2Uf2TWDbtFVSdUjiUPyy9Prr4W+IfVF2oRBZ0koxSN+XsBMHbS8bBz30TLP
         6rj4t9sUJizWkrW/nbbfQKLslxShSS0uEZZzWWK2f4idKbp/+u3LUgbPQi2gqsEgKuSm
         lbI3/15p8QqHwdna+Q6E/qz3j+pYKDz7TFJaGPnnVvW3OrxjV1uC8lx7PUxhAP8b24z2
         1MVxsyOxYTIY6TOcvYCpocwQHCgbwXmFGuA7OEG+ml9cQF9H+KxKFlqpolSmeiLGo3KB
         +53kmP/uoJQnidGg/lsvrBROYXho4yYc6bMD7kLoT4ZneLNJkXkzKJjeUQbZdtrn5FFl
         MQmA==
X-Gm-Message-State: AFuF++kDG6ZnqDLhm2Nq3l1tgtJ1s0+tgs8cevkUO4RHMgl7AperanaY
	zrgNzAhxTlyMvPq47pXGIIYI3oGGtUAxu5qiKHOeAe3D0ScJnn5z9Ni5mcuNtGbT52AFEpoGJr2
	DfdODB6W6s+5RC2y6DCfFV2SVwpPFV1FP2udseA7yvZWL4EDRC8r7lJbhM3Jgbz74E9bJY7QYOx
	Q=
X-Gm-Gg: AYBFou1tm/vFBgCPEHRJ0ROAtTUtZKkBVG/U0LbeU4imoq6fGOvO9WeLI54JztEo0jd
	4k76QuV5wlwdyvbYokSmecuLq5dwd23Ew6NU1p+kneAR0YTNdvSNToAcN+sEt+yIUE67fPGTr0C
	c1yIgifuJM5d+37nZlx2T3QgMLDzGsPso349nAWV8hnFuie/hHrK7dbpcVZ79tnr8li+Rs3zAZs
	YtM6jIvyjwfEqmlGIOG86VYxImJPlNYhMR/KRlmCEktyMrXgM656bw4PfBbaIqqiwfMWoQOefiW
	keiJ7qlTU0hCwmXuwmpN+JECeSYfs/RTFW8q5GIwcSFZ216LPCKmNwxDsGoK2d30t+KnZVwxJ0M
	=
X-Received: by 2002:a05:620a:2b96:b0:939:6d22:6fd with SMTP id af79cd13be357-93bf55950damr200311085a.18.1789832405849;
        Sat, 19 Sep 2026 08:40:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2b96:b0:939:6d22:6fd with SMTP id af79cd13be357-93bf55950damr200307885a.18.1789832405432;
        Sat, 19 Sep 2026 08:40:05 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedac892esm211835985a.25.2026.09.19.08.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 08:40:04 -0700 (PDT)
Message-ID: <5717a803-805c-409f-a9cc-d0c33a365570@redhat.com>
Date: Sat, 19 Sep 2026 11:40:03 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-3.1.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is basically an AI generated release which
is way I bumped the version to 3.X. Most of the
patches were generated by vulnerabilities that
AI found.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/3.1.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/3.1.1

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/3.1.1/3.1.1-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/3.1.1/3.1.1-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

