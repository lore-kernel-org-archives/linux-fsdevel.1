Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587754;
	b=TIeRU2ki+d4SFSSzqXTrF6dT+AK3Kz2BYzisVgyM4ZAALJQp/0hJcEyXHxbSj4vmN4G7
	 4/x5mxgIL4GfPbjqaHkbhpQYnvj0hDEMpWjx+NLfPJTh38PuJw9CTU9Cm9urmaqOI5Lyd
	 BVMd6rgxBvIUx7lI2b3sRQAxCH3nVTzQmx6tcRonDrJrykGetExOMWbfwFqaQWCSUcOn8
	 z6yo2aj5ZeYjBEcA/7vcXM8d1WuRngHMzN/uAyc/EjCEVKOiI8ZyYgznCANtNAN2qGwgK
	 4O0/Z0ic/KHLCZGJD7vB0b8OKu2Hdd46dRE9X6CVrgIvvOmpBQgnj98ajtYz5fFY7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tjtx0YAdrMpcvwQv+CSokdx6fTpn2TH63lyYF/I9Hz0=;
	b=jHWXIzOaqRrTKPC4zcwltTF6ZruK039zyUIlGKmD4r5GA8eBzYOx9h011I1YjgsBUh5c
	 ONUzt7AXl3hgkfjI/SEpHEBhyl1OOluxegwGkMl5NWzMXnCh4tXRDEnCZdI4bNGhb5z77
	 iLiwyZOlyJ1OM1E0pFcX3x7m0KYhaGWHCOSItDNdPOrB7njFAFI30SwcddVQs29gwk4+W
	 kgYnaG5jJ01NvVp/QUAjNzvteOwuEbYa4dJo9J5k2eXq1jc5Rm8m9ht8JJQpANtWCt7g/
	 bo6KQfam+a5d29rSwPX48DKn1WXS2h7IfpTOTOsL54tjMAmUpPTDHRUwKzHXMJqCHMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqpqaVI0;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFE606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 06:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqpqaVI0
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-492690dd5daso4043681f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795587751; x=1796192551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tjtx0YAdrMpcvwQv+CSokdx6fTpn2TH63lyYF/I9Hz0=;
        b=UqpqaVI08vg/ZUhs0YfTfM7EKN+BktLowjhHqXircA9B0nqfiWU/3SND1AkqbSr3sn
         /AVCl002szn2ePT5T4LcKjz1yWsIeJHk63uWnEJ+OOWpumoKerzXDUJIKFixz8xPmcfj
         a4QG/ITjUiPWrOd2Blx4AJZBlolGuRgZbwNaFUVihOQQ380cAaGL97Gd6pBeScNaj8Qs
         YLQa8XAxh1RgIn57M/1/qHlztxfcjoF0zKQDaH3w/y0pboJtXDX+L/aS//YtSZA0rdTj
         +z+vvN6r6+BvLvDuBRHIZOF3VPAGdXvR2wCtr8S1fH3nm+Gf+5lr+4EdAuanaY3lITdq
         3rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587751; x=1796192551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tjtx0YAdrMpcvwQv+CSokdx6fTpn2TH63lyYF/I9Hz0=;
        b=VWcePAangPJwRjeCVqy1S6VBKvrZ5zcESMzymeCXBfcYeUy8wEYSvVRJANy8wg+g89
         kao771YNbWGyL9XtJCHy9c4k+v96ClGLSmbsNbUg26AqWoDHdQGl48iPzmyXhKmMNt1b
         WN9pTYHaZLA6tldIWh0y6X8CB3OlHjYCoIClHwFTBK/PSQte9Q2uu10ONMbJicI1fHpe
         aOCcvnZdo2rEmi2fWbOqtAPVV65kjFfEuH+awLBExr3vqW5JeiD72CjK1T5XVTpvVxix
         AffCheG02Ig+CotagJvmhoW8ya6R+raIITqRJe97csyBXEvJiG/8BitCSVsptNnVHRXn
         odxA==
X-Forwarded-Encrypted: i=1; AL+hErEeckc6PDqHeuEG/2Q5Aeubd9BmVgbEQB/NOF9BPvNB8xc1Mlrj8J6aQu8SFWSMmomsw/iFd1l1xC9gTRjb@vger.kernel.org
X-Gm-Message-State: APuU4Z8BsEQ4M1gF8AnE/bIYbgepJQQxon58tM38gJjUpK7En4ooR040
	Iq81Ldmo26dBaz1kJfmB7ca5YKqJj2d3si853JQpk9Cnnitc4DF3Lv8Q
X-Gm-Gg: AZFdTZeMiZJ3f1qYO8CqAbsi3iIxff2k09qs0amiSwVDk/QYrNz6e7dasdVzhaAzXco
	muw9ijzZv/uXwYA9GcZWApSUXjQ7VHtLgWkY1UBRJcNtJo+pKJPvQtXOiJTDzaO7fuZLZ6UU5/7
	+oPArpGgcqF0tq+gqmP5PnfjV9zQSUJvJ4HW+2LmUzEPPloFoBSdE89HyY2rLuUaqjVqsScuFwn
	vyYOF7xxlGQbSNTjpNtVu+pz/TVM5TUvP/M490TN0pqBbvX/sIG7siI0SHA48N2RrYfArEm/t/V
	uVg0thDWzoCCV1VbR6tOtxirfcdr0XM6YUgD8Vfus4EL/WMFwhnjeICTzItas3N+8o3bOKYrqT0
	0U9EV4rw/YlRG1DV4cLAPibV2fOO4sKhhj7e6MtobwgObFa1yIe7BHOLT+lR+4GoWAoyEWIIMGb
	j0NJyF0+pPsdzx0jDaBLxmIA6BNN9cHAalFuxiiq5Ni2TzlcKwBoqIK8KUJfbnalt4WYHCtIvg1
	vbLTvU2c6UTV1r4VeJSSgyuqoyv2rpEZSi5Qol/b3qukOt2hEyTy8DZ++3gcoCsllrwxLohhkZS
	spHLuvWNCpP+Hpe9G2UGzEl7lw==
X-Received: by 2002:a5d:5f53:0:b0:4b7:6ea2:54be with SMTP id ffacd0b85a97d-4b76ec0df5fmr9041902f8f.14.1795587751217;
        Tue, 24 Nov 2026 22:22:31 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab9cf005f2sm26407054f8f.45.2026.11.24.22.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 22:22:30 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jkoolstra@xs4all.nl
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	cyphar@cyphar.com,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	neil@brown.name,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v8 07/12] vfs: short-circuit MAY_WRITE access for O_DIRECTORY opens
Date: Wed, 25 Nov 2026 09:21:46 +0300
Message-ID: <20261125062146.940336-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024213539.1307600-8-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-8-jkoolstra@xs4all.nl>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jori Koolstra <jkoolstra@xs4all.nl>:
> Requesting write access on a directory can never succeed. Rather
> than performing a path-walk to determine whether the target is
> actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
> (-ENOENT), etc., we short-circuit to -ENOTDIR.
> 
> Currently O_WRONLY for directories is only blocked in may_open(),
> which happens after we have the inode for the target, so after any
> create via O_CREAT|O_DIRECTORY.
> 
> The advantage of short-circuiting is that we don't have to add even more
> logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also, for
> filesystems that define ->atomic_open, handling this cannot even be done
> at the VFS level, as we can't know ahead what the result of the lookup
> will be.
> 
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/open.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index e43f02ff64ac..4334f30bb7ff 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1343,6 +1343,15 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  
>  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
>  
> +	/*
> +	 * Requesting write access on a directory can never succeed. Rather
> +	 * than performing a path-walk to determine whether the target is
> +	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> +	 * to -ENOTDIR.
> +	 */
> +	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MAY_WRITE))
> +		return -ENOTDIR;
> +

Please, do -EISDIR here, not -ENOTDIR. You returning error here, **because** user attempts to write to **directory**. EISDIR is natural here, ENOTDIR is not.

(I'm human, not LLM.)

-- 
Askar Safin
