Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE93E5EC9
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456283; cv=none; b=UtzXFo/9KkqI6rF4CACE6Va7Fr3SZsoET/KP7+cNfSkWn6tcy6PsvLpF3HyGgehmt+6IReO7jr47aQpZjDYF6GdTlIOrpnTK2AS4PIOmn3ykQIHojgzWOEOLSswkFxJmTAnwRV5DlefmpoAbH4205B3pAElif0xXWPK9gsF9MdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456283; c=relaxed/simple;
	bh=JRNH2XRTEkYHJTv63VfJNzHKgkwnq+3D+tuw5gxbqRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COm9JVdaHzs2EaLvruPw93JwvLMkt0rwnltD0CdyNfavWi6eTB9oXSXuW0tSBJ3DRj+R9kutc6VLjuT7KHDr/+91g0RoTE8cYSBY+LgEfgF2Wy1P5BmLsH0+qA5RRpxKpRIF2yXt1iUVqB4k1WfDvEhFMIwLGzRyflMnhjUfZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irVJQrWo; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irVJQrWo"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1363e78746eso15308237c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456281; x=1781061081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRNH2XRTEkYHJTv63VfJNzHKgkwnq+3D+tuw5gxbqRo=;
        b=irVJQrWodeTBWC0sJDzWmneqBCFIey96xh0nlfQGi5E3nExei5CeqJgrXd+gBqzqBT
         lHIAQmZRo+uiBsQlpb7H+YDN3rmGx0wi6jS1A7o4RNF/WFqqyG9dt35uWREgoL6XVkpI
         yOHrfIC6e7L57WMz0DUNbmNXba2EtneRUKbghOv8re0ont90wR8N3EVmtVu8ZXmmFYp1
         ujoHy74VKoAPh5Ao9YYk0kG0BA/4CG/y88ITkZGcE9R8XpImaykEIS+de9Sffy08kJTL
         /fRzDbyxcF8kvxE5/7ELlJS8lyRg4JUpRCZHdfQpnsw6jGibIZ33mMVB5IKrCgQT+ADA
         iMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456281; x=1781061081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRNH2XRTEkYHJTv63VfJNzHKgkwnq+3D+tuw5gxbqRo=;
        b=bpuUTEm0P/jXql5yYmHC/iu4VkDJbHasAOfF4BaBujpqBvoOUv7FqHp0AY1SxTIn3x
         BAw0nQKIopQgFRDUezuKUwPGGjE1rUJAFZAdCAI5dr7ThoCjW+1xji7P/BIwc6ron3Rx
         y2IAjVXmBWHPvUxeBI5/yZCXz7MVcONO+unjfhAzKMvSKq3csy8ApMhhCAFAY/aVaWgg
         Ae1U6WSS46olURR4DBkE9nZUsmY02ZDsk2jAB8MzjW5RkWIwks/D7GeFCt9TIYkasxFm
         bmwMvGSimgUdInsPj+JEDVyDCNJDv+Q9SYcngGmzOaOoeorjw6pyO+WHsdrYVgNJDJJ/
         Y3Yg==
X-Forwarded-Encrypted: i=1; AFNElJ+1Xxh0J+KrLxk/NnbCsLsCpQqINMn2WPDfYyLDhKmFjSYjtyUecTzyrKhdvcuYrr94Z3Vah/Tj878GnjYa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+3fGkdBRhbxVskrlFBfeA/S6VZQYnchPJlzoDBlPB3kw+kRC
	PKP9HhYqepwKdyy/zv9VRI7NyZ3tiuwjvvhIZ1ga2VAIlnSV99oV6diS
X-Gm-Gg: Acq92OGXlC/g13u1i/q1Hh2ck4/UVqRB8PUG9IoxalyF0Y+scf7MV0pJz6vvJZXUmRL
	qeQEbSwWPTpxGhS2/AuJFMd8SJtAJsOtjM9bKefUvHr5t1c0DHvHjv2ZiCWEn2DmTHGaupP5AjZ
	UvTGAX2zEI2lNx2AsHk7mg2nYgtnUXvJ9/JIuVK4jvrB6wiLZ3F3uCSqz6BGiud5br6JhWdEc+f
	kSvhd+yii4jRvtPZ9D2XEPK7l1Ta9EkGDMRNusm7MI2bYpM/VJjY1kUZQUu2ROC6gvxf3ygoRf5
	nIbahNJME/1TNwGd70zB+rwN4F6T9sCI3UAjICv4eobZ2Pda5XoL4v2kngbB6CMKfq77zNML3fR
	YMQO9o7wVq5LLDcvuvPcgoUxF7G+puCRtdB2N+YWjG943Xb0gg2RQuSd0y6YCDJRAjhhTpcWpdP
	kDYL8SJUZ3LQydBD/UcMfvo+3dwLXtgw==
X-Received: by 2002:a05:7022:6089:b0:12d:de3f:d84e with SMTP id a92af1059eb24-137f6c47322mr494802c88.39.1780456280477;
        Tue, 02 Jun 2026 20:11:20 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f554f732sm1029020c88.12.2026.06.02.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:11:20 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
Date: Wed,  3 Jun 2026 11:11:17 +0800
Message-ID: <20260603031117.20950-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603001516.26234-3-anonymemeow@gmail.com>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko said that pidfs_register_pid() can fail under memory pressure,
since it allocates memory using GFP_KERNEL without a way to pass in
__GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
the event even when the group has an unlimited queue length.

Should we make pidfs registration best-effort instead and still return
the allocated event if pidfs_register_pid() fails? But IMO this will
make the API semantically ambiguous. If the kernel guarantees that the
event pid is registered with pidfs when pidfd reporting is requested,
then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
invisible within the reader's pid namespace. But if we allow best-effort
registration, the event may still carry a pinned struct pid, but pidfs
registration may have failed due to memory pressure. If userspace reads
the event after the task has been reaped, it still gets a FAN_NOPIDFD
or -ESRCH due to failed pidfs registration caused by memory pressure,
IMO this should be reported as a -ENOMEM instead of -ESRCH. But
currently it seems we don't have a good way to register the pid with
__GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
approach to handle this situation?
