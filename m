Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446898;
	b=SmGcBaI2wax/rkKdCyddY57W2s4aQTvOOE7D4LG8gXT2ROnIcvjM96yPNj+A4Q+PVXQQ
	 Vpnfu3h9cKlztAqzQtSA7gYWeE3lCsOsoxHC6yv8zs7dDZh95/DdAJOTRRcMVoZ6xJ/FN
	 KlLHHXWxI8LMCqRLeqklorSPWKEdaw1380aXCpvN9iIEOFEHbzsCQbTFTHSO84aBtd2VZ
	 0BoIbNEp36DO33w1rtnhhkDFO53VESxuR00fPvLu3i67z5p0oBPDb+Bc7ykqFbQTkvTli
	 WWoPpUoYr97kXoPPSP3f2Zfj6wDlsniG1SdTzY3rofs1/D9hYLLm7SLW5gTKpeqg5ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To;
	bh=L5M3f6tXuCeudVEXZHMryiVzKAWS6njMK2AQVRvQJEE=;
	b=dsqytWzKrzsr+c4UCVBF+QlXkS97pKL6l0Q79Qstd9sTyGwcC6I/TdNRFNDXW8bORZDm
	 Y1KQA/mfJdy0KqEYGq/2XwYw0yslTLp0c2qVHKlyDrByrs+KuHpvc3IwsHpthB3RVcFPy
	 3/1AZPTYmYNQIWdVk+IGI5L1sUDRbtGAGcN5uHZVJyaUL3eSTkFXBqKr0xQIFKN3m+xeZ
	 EqLb5dS4I77vB/VGSjtAF4jzTNgMp7HF3CUKNxuM+r47oZn/cYG+TLUcDcQw0k+xME3Jn
	 0tfh6aGYM7Kj/SzY5748Bxr9jFr7lXgM1gztVUDqkKYyAeaMHyp8ELlgc1BGKdqfK5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HWJhogjW;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1B606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F1B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HWJhogjW
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3067126f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 07:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446896; x=1796051696; darn=vger.kernel.org;
        h=in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L5M3f6tXuCeudVEXZHMryiVzKAWS6njMK2AQVRvQJEE=;
        b=HWJhogjW4F7JhplhpATcu7xz59o+fdiJyJlkt4Gd5l5/alTmIffqCyC0lg0JI87ZC2
         fA/OtviKtevbQLCl2rIUMBl7Ek+oP1Ud7Pjnca/Gv0LTzFPZZDRFooI76KWfhXOqv93h
         9uP98akzjfJ3mjOzyCA2srhUm2bD2Ry1Bxvs6nAw3OPXRN6Edbamdyhho39D6Bc+02rc
         ZuhDfErCAJzIsFZjkfDLHMixxhJjOO7bDj7V8iq52XySePXOBpm/CX5ufH5KlPItNWsZ
         CAbXKtJtwZMPPhH7O8d5xBhV5U+gLxoKlRN0stX6IW/2cWExG+NLrT9GC8zOp8ox3ErA
         /sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446896; x=1796051696;
        h=in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5M3f6tXuCeudVEXZHMryiVzKAWS6njMK2AQVRvQJEE=;
        b=FIOf88U3sp7JeQjbEgyrgH8/IV20W+5ZZtnQaVXtfqHiYR085SRdKv+BDAPmuEUWX1
         aMgIeMfVYk3GqpnFECeLgiebxiWcnS9qMGVf/wKZwGgK8h3oFm6ZduXRQ+3tH6htnFDa
         IK+H/nx1qPqu6VBJ3sYiVlKezWuNSZZRJF9NqvhR1KylVn4gUIB8QBCnFzYeRgBINw4Y
         GaKHfMkK3stcbgRLrMVl5Dn1KVWLF0b/O/vrgUc6cW3M0FaVwctsKi1LXUHAF3KIBQY8
         m+STqR1ipxhgCBh5OTKhaINrGwuQLP+EhUS4JUUe7nBvE/5yWU4iuaaaN2HwPexWTWnN
         HIsA==
X-Forwarded-Encrypted: i=1; AL+hErFUcvSvbz2cDmBcD8tCMk5gvAys9upunHUN1hL7nBEmr5CTejOsr+mcVPHMAkto4O7i6RYXN3i0SudKd2Qx@vger.kernel.org
X-Gm-Message-State: APuU4Z/638bp3q18/dKzluL2gyVmlcG8SVhQchDIQZXXsXZwgSO8VBSI
	RltBFvpeMbk79qRV6zEY1fC+JotZHbpgllPa5bs/VoY6J8pLsL8KrW9gd2HHFADM
X-Gm-Gg: AZFdTZefOfOBs9Ul07Shjl7AGaxRua8iiPsxOaHRMWr8BNbRVtkmTrOrWf0aeyzZweK
	/Loxd6ZHuc5Ldu7Sepff7w48xEhfAhuh69siWK2BziKL5gd75qVc2jkTe3E/yKQHV8//t6QSWFp
	OFxS9uqYnoz0ZpBd4o/yRW4uglEcd7ZavwOaxJfi36hnR7/+mJYy2NXVjx2TBj1jqFVJ1JiVLQL
	ZqCwcHso+faM7ibGqaqNI5BxmmFdcsH6i5shpTtI+rcA6bb3rrGw2FjyGMx3MsFy9i7evL91AnC
	UPkcK5GFT3pkDrTdMvxRiH7y4ygskzpYDjX9Fm3aeRPQOwqwvEB2hDyrtndg6myMe2vWJooynOg
	KgXMlHvdOiAWrPu0iFtr+IJTrMGumMDQNHaIkgvCsGY4SaqLYg3iqgGUSLHL5/+aeWxQONcpXjD
	Khr13Q71hEOBkhz3p7X+NBBZSa3hG/g7+bzM5z6NV2UmBjcGe2TfRwjyyX6vufg4Zke5ykLM7/G
	3G1H0JJvMGl6iT7PWcdT/HqCKV27a9aTsBl/t7FAKy4whl2C/stcfnA5AS8+9Ozb42VgFap9nN9
	HonBcYD0zY4DmA3basAcVoW9sajyx+c7hVbogMWRzdcGkADvJi7kEYt4r8fcvSuk1enhqB5i3qI
	dgSg=
X-Received: by 2002:a05:6000:4b15:b0:48d:df08:307c with SMTP id ffacd0b85a97d-4abb8ac0d92mr20304624f8f.44.1795446895827;
        Mon, 23 Nov 2026 07:14:55 -0800 (PST)
Received: from localhost.localdomain ([196.178.137.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm19778632f8f.17.2026.11.23.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:14:55 -0800 (PST)
From: mohamedalibouhaouala@gmail.com
To: jack@suse.cz
Cc: willy@infradead.org,
	corbet@lwn.net,
	mohamedalibouhaouala@gmail.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: update filesystem type, superblock and inode documentation
Date: Mon, 23 Nov 2026 16:14:38 +0100
Message-ID: <20261123151438.47681-1-mohamedalibouhaouala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <p7wf376fhejkqtke2l6jxwzytlhiiaidjdaeapw36jxukbk2qx@kyk2wc5m
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

hurn>
References: <p7wf376fhejkqtke2l6jxwzytlhiiaidjdaeapw36jxukbk2qx@kyk2wc5m
hurn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jan,

I checked the patch against both master and vfs-7.5.misc. It applies cleanly on top of both branches, without conflicts.

The previous documentation work I submitted was a separate patch updating Documentation/filesystems/locking.rst.
I wasn't aware of any ongoing work overlapping with the changes in this patch.

Please let me know if you had a different set of changes in mind.

Best regards,
Mohamed Ali
