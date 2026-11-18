Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021194;
	b=jI3fanSC/BP/mF9IX8s7EoLFfZjw9FxHNYA6IFg3C3kWSOpVByQbc+f+vAJC9AbMl6ZC
	 NLTYqC6q2ZlYMYkY6tkCiCzPtidFroXIpLc71ylm7C58+lfViYzCE4YOtj32E+wQXlusG
	 VfeECcwzz5+BFAQBz52TW1i8+BPLIkhAbJlDX9SnH10uuE0B6pJv6znvGJ1iH2rRxDRo9
	 WzbDZs6YJ7k23K7Ql1moGfDUdZpHKLAjbBzXVrMCVkyWtvPaDQyFVOaeETPeXlbcPt1XS
	 Ff/bnX0VPsvbnwWXp7cJi6RLIMAuZYwBB6rexfDnQZv9EgYFXOOh8tKH6SDtkcLGNBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=SbTYA3WWftMVrKmwOoy/6f/vZwikSAfbNlm4H6PwnQU=;
	b=FqxH68RF6tKOidsLfm9IRwkiFpoQWp+AOokoOY5LHH8nYfTyDEjFill1n70W9j9nvAwL
	 aAnfujPVS6OE1YXer0hDOX7NZDL09jJN7PBsxFxbyly3+Tx31U5SST4saAc/MsTBNqgLL
	 ocbwVgpfIYCaIQ2nx8OoiDXUQl6G61x6lsq0k/Wg3HWUpfBqN7Rpw3QbJu0tORbjBqecm
	 wVNvaav1TfAS06VlMKWnlp4A6VCD/dAOpXTWwEW7oGv8b79euevrs8BhKof2b5roPPnDv
	 zRA3ggCySk1Wl1h9qFiyRJKn7Zvkuw8F7hw3KiX5/VE/wx8WZSh0l7oFktUNQjKnXEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP1Zp4Fz;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03115606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03115606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP1Zp4Fz
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so2172997c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795021193; x=1795625993; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SbTYA3WWftMVrKmwOoy/6f/vZwikSAfbNlm4H6PwnQU=;
        b=kP1Zp4Fza7LAQyUqypyaAhV6hvS9maeBk7Ez9UkDTkcZ6p2O/rTm6xKsVwXHm7wtIb
         zEtJ0jOVT3ZAXliTLP9x6BrIYgPZCPkAzJxPaq8QHVEIhPbBwBFXkb8aXJcs24Z2VdlM
         gh1iLAxLii1REJ6OZET4tUET9mX64x0PLboP/yTa7a8DlN6JQ3H07z2w3tYlNHcLimO1
         cLLjMVXqxxxdZkD8NxRqLzrVL1POMyV6q34IRykX93wr1SDiEVUnwvcR/P/B0triLpiU
         0C4PX/abCPLLNCC4Nj9zC2jBnBuxoyJbA657l0QdC5JuFqImVK/aGtuyMtLLNrUELBSh
         sq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021193; x=1795625993;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbTYA3WWftMVrKmwOoy/6f/vZwikSAfbNlm4H6PwnQU=;
        b=OgiwaXpwtpe7S7o/fi5GKLfqC8R5QfoADV0lm/KC+wHd4Z9lniJjcXGYes0geNGTqL
         f/Pqyt46tzAjrsvhIvNzd9YSHepAKMDQ+nz2PnoPm2G8/fMnrDRRCf7gUBsrH1KO8zXu
         JX6+cUEtRt5w8JPt+8WpEM7ZpxLSqw2IeWxrb2hUfZiwsoJDZn0aUOB6Fsque01Cx6RE
         xwL7Du0Lkha7ZfDgW4nXVyi+PgRFvBjPIyAkmP1GYMPWd/Q1Z74B14nZ/Ir/Zg+YYQLC
         eL+QifwfjCpMY9FQTzke1xJW9iues+ncLeV1rcustV/ik2hkyoS82DtfMBkgGVyZBLKB
         IM8g==
X-Forwarded-Encrypted: i=1; AL+hErFxSjoEx3ucmDg0bavl+NyxahEhSh64K+Pdlrm6S+ZWjKreiNaVewOox+A7cLqkw3MlpX/okFsXa1e73tmn@vger.kernel.org
X-Gm-Message-State: APuU4Z8oJYdGm7X56dFjyUHrnkQ0xVxgWS/z7Sqfa5JVUGpbgXRwuaXf
	8FmWU+VLTXYtXbX2p6xn5r+db6Ugy35MGG6QUtrn+2UyVjJrKueHgQjCnjXs4T2l
X-Gm-Gg: AZFdTZdrvemmwb7jEFV8bz6gkWVDtZ3XaPwUgPa/A8A6Zn8SuCpqfuHwqEc34gr0gS9
	c8XaJZXMHD/rxDpm1m0/QS7GR7B30aQFONEhfoCsSB7E4c6ant089/Cn2ek9gkWv6RWu2awTf2N
	n13dINQeRh+DeJWKmjiIjGK7B7a/LIg0R5aoN5TMrhSP2VAgwctIwNNsyyFlj642b7YpQmKtx7H
	ojJlUDIXB0NvU1u8Fip9yJhjNAa8wbLsbS8TMeyAil24ITbKu+Z3u2nrKj+y37h1mJUvuCekjTn
	gE3j3LdeJFzBmZhMoYQu0pI83gSeN5u8ZHJ1N6MLE9QlHUUKbOH3fd7FlPEEqdCEw4o9WGa7DZf
	nVq2EcTNdtB8EJKN1sjHjyrtR2lIHmQmGn5t7UcWk9F+VdaY2GwOP1FDS7QxSmjk35cKM8zYBpy
	bwZbxcAsF/CV3oDUeyP0bPLIIa0O05+vbsywHI54aDvUMeVAWzcR2vJNpWczqA9J0SMYYBvEQSZ
	w++9GRCsajHVJWA6YBMIXnt0po0t+nTDILwwgfQW0bHgREfMhD1+8gJu2swBdGkqKKRnqH+OSAo
	jqKYXb/FS1a/p+jMt4OV2VqpNRq7+2EVwAhiErI=
X-Received: by 2002:a05:693c:26c7:b0:378:a35b:9e1c with SMTP id 5a478bee46e88-38281bfb0b6mr2545582eec.37.1795021192841;
        Wed, 18 Nov 2026 08:59:52 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:d3ff:1383:d316:8b42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a80bc19bsm9180943eec.29.2026.11.18.08.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:59:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fs: sync: fix overflow check in sync_file_range()
From: mdshahid03@gmail.com
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: mdshahid03@gmail.com, brauner@kernel.org, jack@suse.cz, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261118062028.GS989762@ZenIV>
References: <20261118023452.48090-1-mdshahid03@gmail.com>
 <20261118062028.GS989762@ZenIV>
Date: Wed, 18 Nov 2026 22:29:34 +0530
Message-Id: <179502117452.61665.3127081747764752166.b4-reply@b4>
X-Mailer: b4 0.16.0

Hi Al.

Thank you for review and feedback.
You are right that endbyte < offset checks become redundant for
non-negative operands when check_add_overflow() used.

However,I have also missed one aspect : It also rejects negative nbytes.

I will make that validation explicit by checking nbytes < 0 along with 
offset < 0, and remove redundant endbyte < 0 and endbyte < offset checks.

Thanks
Shahid.

On 2026-11-18 06:20 +0000, Al Viro wrote:
> On Wed, Nov 18, 2026 at 08:04:52AM +0530, mdshahid03@gmail.com wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> > 
> > The addition of offset and nbytes can overflow before the result
> > is checked.
> > 
> > Use check_add_overflow() to detect the overflow safely during
> > addition.
> 
> "Safely" as in "doesn't rely upon the -fno-strict-overflow we
> have in CFLAGS"?
> 
> > @@ -233,11 +234,13 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
> >  	if (flags & ~VALID_FLAGS)
> >  		goto out;
> >  
> > -	endbyte = offset + nbytes;
> > +	if (offset < 0)
> > +		goto out;
> >  
> > -	if ((s64)offset < 0)
> > +	if (check_add_overflow(offset, nbytes, &endbyte))
> >  		goto out;
> > -	if ((s64)endbyte < 0)
> > +
> > +	if (endbyte < 0)
> >  		goto out;
> >  	if (endbyte < offset)
> >  		goto out;
> 
> Why do you keep the old overflow check after having added that thing?
> If sum of two non-negative long long values does *not* wrap around,
> it will never be below either of summands; that's what the last check
> had always been about.  I'm not saying that it's worse off with
> the use of check_add_overflow(), but mixing it with the old overflow
> check is very confusing...
> 
> 


