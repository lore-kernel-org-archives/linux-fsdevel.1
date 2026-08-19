Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A013451C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144605; cv=none; b=ilLjTQ5xdMJ9drq1Xb4ksVcd6i9HdnfLhK23D7l4w2WT5V2C6DBwtIRMfbzpeIYPqYAK3xBPS96Fp0CiM9IgDUR/fV9tS4lJuIyARNlJ8oF+FrtMNo3sJNXDZim0b+oHDOhcXzYHfR2TzMVUOG7X0x42LD4ul7PIOPzwT69rn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144605; c=relaxed/simple;
	bh=WxtUFMQheEK0+9+vO3wducy8yRjA9+2PgmYFwwDaa+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdcJQixnoT5AeoLj6K5O1TK/COvAbaAZE/aZjP0hd7L5eXwf3SjdA77USPFPW7iQkP4r4AkhiVy8zqWNeAJcn4uTpC9Qq2I6UQS1ttSrogp8ihsnmD0cNPLEswFTHDW7zHvbcvkRtiourGEOrhDtqdTG9hW0kwz6EbVc9WLawA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TenDGLOn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TenDGLOn"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a181e96cbeso9081681fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144600; x=1787749400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8lfaCFmNaWdgZAGCTvVDVA3Zoz9GOtBOEP81J60daI=;
        b=TenDGLOnF5jqgtjwCnCwwiXbg9KlG59wcdx/Vf/xEF9c5C+fKOiOZVz/xP00vo8/8J
         BPamLZ/Z6yq7YpdUSWGOAjU5/RhQ7nnDtzQa8hN7JF6LV6rIbvif/ujClcddQWxabpO/
         L2GcAiePs41QPUir3/sS6MB4GKXqhTDCx/uwyxc9N9wcReUcilXMzHS2YJekIoTHvblS
         G/wKW3nNP7hxBuCXoxNLIU/EX50MpmEkLhqmQQhJKINDVjPJvTx/ayCV/iBZjpYIMcgb
         EIxbtfzjq1ScYllvl2i4lXriAYlsOZXb/sW0qrxEpA7x4E/9BodLzYs9gpo5ePgyuS2V
         uJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144600; x=1787749400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8lfaCFmNaWdgZAGCTvVDVA3Zoz9GOtBOEP81J60daI=;
        b=YGsLiPIt+AHL6EjEew9INrYTDKExq5vHfk8SQV9gGKx5jHaAuBUeIt4M4iQRaLaEZw
         bta1mS+sbDuGgJ2l3XxjG5dZbIAXQ65NNeTimm6CW9MdnkG+F/izCKgy7gStd1S6OTdm
         MPQ4YMqoobH3HBw9R9aEp8FAyCXXPgpJOmGI0ghLxTyGuEefqFyGnggrvTZZcUbXPmZU
         Fzhq2SYU1qYJIpHerL8WwNLvdDU88nz/ySX/9SE19OnvPcPHvjYAe0f1UF5AFUxzxUGF
         zmb1bY8Gao34zIpp5GMy0ZR+JO3afe+VfR7RjL61uvvlqIpXNtjqSbW6H+pE4fcDIG2X
         ld2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrTRxY1P2t1uStMSdAmAxrS5RkCGtKT49FJExiXuYYM59oSKtdeC69FKMho1czjDCVHwWBUsVyowjA/DzXJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLLhQBJ4k3M8Y3JdkNrQcsswBD7Ja0Ygf0XSMB5nWW2fSesnW
	LUcjB3bkv2LW0Tb2b2MAYfDien7an5pkUeWFtxOCsqvqeLJGt1JX7Fjz
X-Gm-Gg: AR+sD10ZzxKSs8923cBA2YuXh9hW1we+svYTond28uC67pyNLVBVWCRk+ED84x1Ubhs
	j2GT5IRrLP/CV1Yfvz/eoXvUvcRaBXRguCiFT7lovmaxyaH9FMlDSP7w5KmJKT1q9XsYSggWl9k
	E1JcE9ffJ/9b3yorUlLnlLxYraHih22yWC5bCaDYjGkpwa1fPawKiMqMLZ1VOJWE+rnb7CIhOAR
	7hk6AHHW13Yyglg/ld9fmRMVk8jNwXOucm0x7LKmzAFjOBxYKR3oWhTPxoZuH3/9PxuccHmB7Jl
	Qkd3358GqUA7iUAUXNdewr4fh+ml0fs2seBo6AGBzqyvje6Js4RGVpac0yiJ9LgSY2fALEkrzBX
	KIcYBm21jHlgORqX+LyJ5sp8a1PneFWGwLmXMRbaYoNCQBhCx9A2ZHQswGFWOk7dWoPFLhv5YrH
	mqoPWRG/KmivmgE6w9lyjRmDWxfb4/PPrxbSiMoca7ZWiS
X-Received: by 2002:a05:651c:19a0:b0:39a:d7f7:981d with SMTP id 38308e7fff4ca-3a1899e7070mr11061561fa.12.1787144600089;
        Wed, 19 Aug 2026 06:03:20 -0700 (PDT)
Received: from c.. ([213.165.253.80])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a189e43938sm4935901fa.41.2026.08.19.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:03:19 -0700 (PDT)
From: Narek Jilavyan <njilav@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: do not cache a symlink length that disagrees with the string
Date: Wed, 19 Aug 2026 13:03:17 +0000
Message-ID: <20260819130317.2864113-1-njilav@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ymvbwy6meo6wkp7fmkcuimqk3k6idaurijrrzpd6uqcbxirkkb@2dpz7trwewc6>
References: <20260817161730.699293-1-njilav@gmail.com> <ymvbwy6meo6wkp7fmkcuimqk3k6idaurijrrzpd6uqcbxirkkb@2dpz7trwewc6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue 18-08-26 23:35:53, Jan Kara wrote:
> I don't know but to me this looks like overly defensive programming... If
> we call strlen() in inode_set_cached_link(), then why pass the length to it
> as an argument in the first place?

You're right, and so was Mateusz.  Please drop this one.

Going back over the callers: erofs and ext4 both run strlen()/strnlen()
themselves and reject the inode as corrupted before they ever call the
helper, and shmem and ext4's create path pass a length derived from the
string they just wrote.  Every caller already guarantees the contract, and
the two that take the length from untrusted on-disk metadata verify it
independently of this helper.

I cited those same two callers in the commit message as evidence that the
API was fragile.  That was backwards - they are evidence that it works as
documented.  What actually remained was "a future caller might get it
wrong", which does not justify a strlen() on every symlink setup, and, as
you point out, leaves the length parameter with no purpose.

Sorry for the noise.

Thanks,
Narek
