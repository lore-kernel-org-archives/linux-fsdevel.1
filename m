Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587121;
	b=h4HTSuG1EqMK1fOimh/pDXlt1yFdSSF0KUasEGgUCs0PzXel83RVQNriM5mckrc6fqBZ
	 fDJEAh2LB+nae3Yew2poc/y/jmaTT6fyT/AJpJbAkfMIwdYAJ6mcMKIFlEak9CAQasCUz
	 dxL3ZYjM+xeUPA6gAPJ7RQY5R4pBQFomWqAZBDeOzNfDC+AXdvycjVHD9XaupeCx8ZEk/
	 nFJ+6aFkfiLSjiNenkMdHgR8bond80MG37lD9gM6sJz/6QbT2tRTywY5mdp7Z1ZEFkkXA
	 VtIskcRwiiRSWWk6MXirMFvgAtG62uAcS+TJxhQKIEKp+YDw9dSyKmDNX/b8CF7rNug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mn8oXMgO7ys8gs1NirtIayuQ3LSb5RT+jR9DaBN+G6Q=;
	b=xCdvJaytlrcgImT85osUUo4BNLomwVm1/FfepwBKqVQHOrqAN6Y22Byawc27H51kIUIX
	 jKLHXMVd3wVHi30bNikPffNJdGWbbZNQQn8ueJWzLGKUNLTsBfXOlIEFCOAifW9nTVS18
	 ZXEkb/CXy1JHu3OxwjVt+33IQ2fxYB3z/NyFy7YbCl+q3w5JAhDLep9oqJ6rcB75zIfb1
	 FuUtTM9ZQOvZq8AEk+EfGVHpIS/+TDZy8NrtmHOu7nmSkSUlgtI1dDNoWLaAeFeQ4aaWx
	 CgoKSpl/fMP2I1vHS+A6yZ7cisNLo368cAdnixqh7oaxKr6ZZE4WNO07mUWdrXi7JrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cG6uo9BE;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F6606A32E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD2F6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cG6uo9BE
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c247f6687dcso97932166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587118; x=1793191918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mn8oXMgO7ys8gs1NirtIayuQ3LSb5RT+jR9DaBN+G6Q=;
        b=cG6uo9BEELzaoqgbe11mFN6vTx1fa06/lNMCeAqI5ThvD52TIVBlyPaI/QS/zP5cj9
         rsEWQebXUX6m4fBiYDoZXhb2PcgNDZwixWaus0ieF8GTUvVLCDg9TlrxbZcqTLasiCpt
         xRFmwOAWYI4+lyJwIc1+qQGi50PtAnu2ULaE3nAfQndJz4auQmhDUR4otzAcBUfy+QDE
         sVDyW8oHUOWXSvsswUPm+og9ZzPpUqrcZqfABBeI502ZA6bSjCaDu89akza/TTmRfWTs
         GxKiz9C1DD4Gz08F4B8JAEvvVVY0Msvpi+eP8y1e7PteaV6i6MRasSpEKoW96ykirHED
         ZOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587118; x=1793191918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mn8oXMgO7ys8gs1NirtIayuQ3LSb5RT+jR9DaBN+G6Q=;
        b=f+vrLspDzh+l4czvFqK1gLeCblCiZ2FdPij0eSp9dc7SDmvAWqcYPRHpaC0Kf+Gmhp
         EwZs0cZ+j5Nqt02DuiKoJQrGv4k2G7dkzDUEmCAwau1zNEnSLkVAlVo+CJmD4fY3BrK4
         EAw+Ree19iEDIeQmf8ZUdsUbDvc1LvQ3+qer2o4fdn0ijbAS0lGZsK70B666BZgM1za3
         kvDj6oFhPt3OF+A/sUoFUqk3kbw/F2JsVwYCXauZC5itxGGM8ITviGn4P3juH4/rFkfA
         YY2RtFvqF3wteWgyfPzBMlKdOSEqKlyQD9JLno5WRx3EGXtsmszcNDul0jkNaEhsVsPA
         fE8g==
X-Forwarded-Encrypted: i=1; AKwUvBwQgEkVZz0CIOZGjgbcw1fG0lKs3R5QERZHEflpetrhZbF5Zd26qw9oWBVYwFZLNBKTbuq6R4D8nR69g7z/@vger.kernel.org
X-Gm-Message-State: AFq9FYJCF3NIi9WE1+GFc0Y69t/GHi9oZW36cDC7d37O4TDzfaBuoGQh
	MzBlhWgID5PKaPIz8XInbJJ2x8W9gLF0PLch62Cokkn5ArV7jgs5TBoz
X-Gm-Gg: AYBFou1YEOIXcktKMxljFFsLd9EYdZhgUMxyTQMot4nSEyBznS0hPuOVJwxuA5BnlSd
	8k8I2ENkHBDxtoln6bIIdhVyp1OizN4Jx0LJ3k3M4X0TcifHZLnX4DBPsUuZIBLpC3cEcRZAS7f
	zDMb9ZfpCQzPWNL03NQGcy1UYURaRpbmI9DK7K4vCtAO+Xss0kj7pB5bUSLAQEqk5KDBvYzSJbc
	LhBtwa9uT1DpdvR1kKHzfldlN+PT/q62cJ9Tf2I1HZC8La9EckCe+ZxC8QBQIxyMy3q837FpWTd
	YG1ISOrEl7bjIo+9NTKKIaGFKtqj77Ve2TfvkzOTcGwyHeRRa/wbDug4VYY6+bCI9i+VHUFD37k
	XtccQAagEExQttyGFZ/NGNXWH5UQSqkSGH+ZLIVPTN6bax9pCoKGJZnvcr/w7h3U0AXsLoWbCu5
	plF7yu845HKyVI9CgTWf45DxzTkt/5+lklqrbbFowzPVM0YNZdjDDSYuHteS5a1YFiqeV5BrTvl
	QY1GaS5E5gqdMhBjt461UCvfuvqsTMp26VvJ01WxPvOGFt7Cuc50Lgv7EMUmlL9idpyNY9ervG3
	BcCXSoerLJv5eq6aohuUmIXBQGdR7gSDEPKkR+Lno7TZVlE54Z92afhykqj2OhyFMPuqWSR06lb
	/IzCQtZLxpSyjPQ/iNlRsqrpD21bBqUor7tzEEXHDxDdsOKdlxSJNw6mHPu40n0h7eAPZ1bGppN
	laFW/c2IdjI+667/Npwbiyo4gj
X-Received: by 2002:a17:906:99ca:b0:c40:9839:c892 with SMTP id a640c23a62f3a-c4679594c9bmr175067366b.19.1792587118009;
        Wed, 21 Oct 2026 05:51:58 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4679004464sm73128366b.67.2026.10.21.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:51:56 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Kent <raven@themaw.net>
Cc: Tejun Heo <tj@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	driver-core@lists.linux.dev,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs stores
Date: Wed, 21 Oct 2026 14:51:48 +0200
Message-ID: <cover.1792577179.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
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

syzbot reports a lockdep cycle &pipe->mutex --> &of->mutex -->
&sbi->pipe_mutex. splice holds a pipe mutex while it calls the write or
read handler of a kernfs file, kernfs takes of->mutex there, and a write
to /sys/power/resume looks up a path that can make autofs write a request
into its daemon pipe and wait for the daemon.

Patch 1 stops holding of->mutex around the ->store() callback of regular
sysfs attributes, which do not get the open file and already run
concurrently for separate opens.

Patch 2 handles the case that patch 1 leaves. A store called from splice
still runs with the pipe locked. autofs no longer sends or waits for a
request in that context and returns -EAGAIN instead. A new mount is
refused before it is marked pending, so no other lookup sends the request
in its place. This also removes a deadlock in which the spliced pipe is
the autofs daemon pipe itself.

Patch 2 changes behavior for one narrow case. A lookup from a splice
callback that needs an automount fails with -EAGAIN instead of waiting.

The series was tested in QEMU with lockdep using the original C and syz
reproducers and focused splice and autofs cases. The target reports were
not reproduced with the series applied, and the paired functional cases
matched the unpatched baseline.

Krystian Kaniewski (2):
  kernfs: do not hold of->mutex across sysfs ->store()
  autofs: do not wait for the daemon while splice holds a pipe

 fs/autofs/expire.c     |  6 +++++
 fs/autofs/root.c       | 28 +++++++++++++++++++++--
 fs/kernfs/file.c       | 52 +++++++++++++++++++++++++++---------------
 fs/splice.c            | 13 ++++++++++-
 fs/sysfs/file.c        | 18 ++++++++++++++-
 include/linux/kernfs.h | 11 +++++++++
 include/linux/sched.h  |  2 ++
 kernel/fork.c          |  1 +
 8 files changed, 109 insertions(+), 22 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

