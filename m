Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B91A9F96
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083112; cv=none; b=tj803eMPAQocunbzg2PcU7vyWNUxwdW/cwTA9M/LlCWTYjtO6agk6R8X4VeRvN3k4VEb18UQTOyqZljAcrDhwk/57K4ZLEYoE1pXaJFdr4LlEbFbQ8BEpodm6W4f85LcP4/4gImFXbOiL/uJHJaGJoInFVLh+oJ+kM8IXvZ7hTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083112; c=relaxed/simple;
	bh=6qqTa/X3m7aLDNRwG0zJozazyQcZmrSLYDZvqtQDqPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkZx6Q2j6/i1u9DslGPbWPYwGTlyIsWoH4dUXZuvft2TQQOHsjoMX3PBY2WTIFUZf/WuWCL3uMAsSHi5kFWdMhifmRJUeT7ueEUrWoJ1pB/m53UlnmiYNf3aJOrdTvkaw/6hMX05RskexT954CgpRj4BS36oYEwplIyc0zm8cqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie/noHvG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie/noHvG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806bf39419so27923315e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771083110; x=1771687910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsUA8VoJa9savfMKxq9ncS/k76ZTIu+ea1tSUhLATc8=;
        b=ie/noHvGcKNLLRT2qOXxu5M+9/1MvMJbHBvc1kVFDALzpB/YxooE4kw9fBFAUZ2qWu
         DkGgdkSbb/OFkLVc0glVzwbSFwqLI7b+r3sLDmaRtQxTv+ucQhSRpgzJGNexeOhb9fj3
         7Ql9wNlenFp+AchFQgIV4jRvyt1h4vhV/kNVdyeY/RdVNy8H344wRwslT6hNykcjYLr1
         yXOTDXqsdoqutJgXAIzxgVfGalsGKTcoeQDBSxwnA/K3EqEhl2UGsqjttCFM/dJesP03
         iO6z5Z7S1/RmSk3lnBfxmgKRDy9lacIkxhhlsjj/u6jZO9iP5VvUnQXFrOfFTmLdOf5S
         b2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771083110; x=1771687910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsUA8VoJa9savfMKxq9ncS/k76ZTIu+ea1tSUhLATc8=;
        b=I26ulkh1yxJV9UuWoA02kXUyjeyDBEDuE8jedezdHjPeD6aVvz8uMD9iy6htlshNIi
         Baml8SkT8h2+ys3RhcD7ARZZMdR6aTHJ3An9QMghQjY7zmCOeeXbIM/p+jNh9nVA2t1B
         fNgoadV2ZRrTRZ9HJPHr6P1UCi5gXcKIX985GnoJ9s0OLhirVzA1jdlOj06x1Xk9jbqc
         +40Klc96YEgmqQewLHdJTKewwWQ5o+imPPHV4jYJ2wdS7Pyuw8nGILoTNHRLzMmv2T17
         kuG5/LFK3SrcN3uj6TE15wfy9GxS6vG5S3s5r46rrIAPQ1clFCVWJAwxqCPF3AkXbbOw
         7efg==
X-Forwarded-Encrypted: i=1; AJvYcCX1uL011dFcDSWxAaWbsc+OUptNhN879MoRggPnEQmNsN96FnNRnyS8iUDy2BzQrQ2TondddIG0e46xyxHX@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYqdH+Zfyaq4pzp+NgeZWRd62TPUdHFlM60GdVmj2tgt2xSzO
	UU+xijyx6P1RJVkbhOOuo8Jn1lwMYc28S6/V212EeRGMpaFyW3Bz0wqJ
X-Gm-Gg: AZuq6aL9x2LlJMjro1zq60gFCSRbBIMIkEJoiIcIO+Gh7t6ugBOyuK3RSFRRnU8HChD
	PlqPBO/Td6vrSq7z6JLtkfHwVLFMp/VBHWe9N+FXBlVmZQLpxHK11ac4aqwJrx2+ztCOaeR7HTQ
	U0bN+e25zvWVD0RA70RbrWv19LuoPd6Zvqp4Zsc2GxxCc9WDnLvKGR8K97w+7yuDfG41NoVZCoX
	/6MAQAUNC5mZMMkGh34g380PrMBsCjeuj7WZddxTe92PJwxDsvOjZRJvJqVXWPk0Xn1kQvyk2nP
	Bwh7Vt4NHY+hKaiS36K0KuBaAVCwy9/XFNmtnBh4x52LxBU1CAjKQtGTAVls2pT6EQSO7A5hLKY
	bYauTAphPgmqOdPe+V0z62bBXLqnDYB6vR8Qj58/k7CwRuuvnjyDTs4F+sh7reWNZ0fPuL7pR5o
	mL109yrZk4c6MwP2Mxcww=
X-Received: by 2002:a05:600c:3b87:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-48378da53a2mr60843495e9.13.1771083109376;
        Sat, 14 Feb 2026 07:31:49 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4835dd0deeasm258334685e9.12.2026.02.14.07.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 07:31:48 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: hpa@zytor.com
Cc: christian@brauner.io,
	cyphar@cyphar.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Date: Sat, 14 Feb 2026 18:31:43 +0300
Message-ID: <20260214153143.1312707-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f5050b26-e5bd-41b9-8b3e-1b87888095a8@zytor.com>
References: <f5050b26-e5bd-41b9-8b3e-1b87888095a8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"H. Peter Anvin" <hpa@zytor.com>:
> Either way, the documented way to use pivot_root(8) is not to rely on it to
> change the actual process root at all [the same caveats are supposed to apply
> to pivot_root(2), but was not written down in that man page:

Unfortunately, pivot_root(2) (as opposed to pivot_root(8)) contains
effectively contrary thing:

> For many years, this manual page carried the following text:
>
>     pivot_root() may or may not change the current root and the current
>     working directory of any processes or threads which use the old root
>     directory. The caller of pivot_root() must ensure that processes with
>     root or current working directory at the old root operate correctly
>     in either case. An easy way to ensure this is to change their root
>     and current working directory to new_root before invoking pivot_root().
>
> This text, written before the system call implementation was even
> finalized in the kernel, was probably intended to warn users at that time
> that the implementation might change before final release. However, the
> behavior stated in DESCRIPTION has remained consistent since this system
> call was first implemented and will not change now.

( https://manpages.debian.org/unstable/manpages-dev/pivot_root.2.en.html ).

So effectively this pivot_root(2) note cancels pivot_root(8) note.

Note: I link here to manpages.debian.org as opposed to man7.org, because
manpages.debian.org usually contains newer versions of mans.

-- 
Askar Safin
