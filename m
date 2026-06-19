Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A832E6BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781890406; cv=none; b=BOlovMnAeIxAKTwzJcCJC5rM9brzhjCDQMHSKORTI+cqmFyzwy03SgZXhcH+RImUuZf9lZ78Spab7zn5tNngx29ZhZdqPVXtoXNrkwk2jPdrI1EVoigdGk5z4EEfOCEuXGpwtykeuwvGh2UDXJbtaizGtXUb7juLoJpQZdzJAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781890406; c=relaxed/simple;
	bh=3QOMV/PEdzRIArPqLGAEk3ALExzbBNdJAPRFE3giSiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1KKvcP5zqYTcXXSgx5dFIZMaEjOlQYR+0ekKdzLUJVAv4U1kfwlp59knoRsc5foKgqf7qx2dsgp5fw9u53G+2iB/UqnBz5SE7tvsvWiO9MZiJwOT+jVn15yy89/18vTFShLIp9Vf7rNGIigLmwPchVH2YmAPyEysyy6QRvFsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2dvWrLS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2dvWrLS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49230a567a9so11795015e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781890404; x=1782495204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHjYtrrWSBHBDIRgPzMTC9IJiEE8dzQgsMSw62aomtw=;
        b=B2dvWrLST2TJnfnBkt4hvpyFGbmbAPck41mRNY96nhVbO8ZOjwR3KvrOcEeKFLF039
         JRdB/9jGNU07PTl8v0w+ruSBvrXmnxrQZX39GIgGLVOfz4EReQJOYok899yhBXRjszuP
         JUeRHNrsAT7/j6xLZIoAR2CwCRntWf4/Infzza3SHejxf8Jjyw1uZfX94jfTSEDtS2nG
         tXhCcY5UtXE0XX/eoT7AI/TsjfOxqJRVJBt4gWgFlxThmbUwNcUeNyOGrvdAPTdoy0vG
         pgy94vpA1J1Fe6h7e+Ck3ECS3jc+nIVTZ3MRGLGMhYNquEelcKUEe/887yXbB1fcJOXx
         uVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781890404; x=1782495204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHjYtrrWSBHBDIRgPzMTC9IJiEE8dzQgsMSw62aomtw=;
        b=Y99sjIINngojGyNbSwe22AnmKx6pVlJKYVEOn4eUeaYsTkd3TAgYg8PwA54gEBZ3Ht
         zNilUtwTuxunkNBW7j7d5mKuZfi0CYwqObWyAp+/T/6IVnAIsFE1mXGe3dKFt3LwkD0b
         G0EsysnsN/5OvIJEYeg301jzPfshTw1EQovxKqWY1PnQYNAEziQzqyctQ9UMRRWMIDky
         +EaMMduyUUHO3W7E9Ex8tG3xYKNdgtjAkjZhyRA9v0sCoKyzb9UPB6bzZynqI6KzQZMA
         MAxn73Iwse6agCyrSPnwnAPLRx4Ku3/zZGDse3yUEmCfDjetLs5i/OUxwewqk0Oq/Lld
         RVAw==
X-Forwarded-Encrypted: i=1; AFNElJ8jyriTqLJGG5SceVISr8rvCNO3zl0nMapDHssrmUSMsjr3oG350IfqMbcvXQiIwtDY7Tyhnk1Visbx6tu1@vger.kernel.org
X-Gm-Message-State: AOJu0YwnG21yKcpq52Inwd8IETTVdtw18Ct0iBne7IU9jkD4FAPkBxGi
	245fzDQZ30on02Jp2qzBN7gSHehKmfCP3PZFKnGTH63ajAy1ita2fwKB
X-Gm-Gg: AfdE7cnHj/6yAUFqktNPqUGhr9Ti7njw/XpvRZGHQp8zrF/k2dWz02ZIuUnCiyKM/3o
	CBX3HGCxPZXP9v8nBIe7A2eeKsvG8ZPrRkp7ilytdif/Kig/Ga4tqqCktoYUGE1G8NJX6lt+1z9
	7+LXgqvN/D6wV0VrTRazFgNN+SgxgKUrST+LuWXOJcBfuYX5viBKmP8u4X6RVajA0sm7vhIcnYi
	Eu+MjECWry1E5wCUaWrWZufDarxB+CoO1fcw+T713hX1aMG7eKN1Od3fm3z9e4hBtm1/yO2YMCX
	UAriwedj8b3sluuatIDXXL637WWgbAQ9D86HFnYDEyWIKQXFXW3VG9N+q9gHxle2YXRhXwqn3hd
	LISbr18H8NxbAvSx59IDqoUHGS80ZnaKOQ8Y923w3zGGw37lEJvyzx8OYIGrmyQyw4GYsBWqi69
	Ogu0lFYlmdWRTW3suBb2vlK6VuwrVmwpUHSB7eZ5mQDcHgYmcQnhGcSRLB9vvj
X-Received: by 2002:a05:600c:348f:b0:492:4636:87ae with SMTP id 5b1f17b1804b1-492463687d1mr36060355e9.17.1781890403634;
        Fri, 19 Jun 2026 10:33:23 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm610491f8f.18.2026.06.19.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:33:22 -0700 (PDT)
Date: Fri, 19 Jun 2026 19:33:16 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xin Zhao <jackzxcui1989@163.com>, pfalcato@suse.de, 
	ebiederm@xmission.com, viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, keescook@chromium.org, 
	mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] coredump: exit_files() in coredump_wait() if
 MMF_DUMP_MAPPED_SHARED is not set
Message-ID: <jt7glnz6scdbnbzzl7l3slvnu4vtr2uzlbwe74znxp3sxeqdtc@dhrwwjhhn6md>
References: <20260619122419.3954581-1-jackzxcui1989@163.com>
 <178187726633.350634.1366346571707417413.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178187726633.350634.1366346571707417413.b4-review@b4>

On Fri, Jun 19, 2026 at 03:54:26PM +0200, Christian Brauner wrote:
> > A coredump typically takes some time to complete. If we happen to hold a
> > write lock with flock just before triggering the coredump, that write lock
> > will not be released during the entire coredump process. As a result,
> > other processes attempting to acquire the same write lock may experience
> > significant delays.
> > 
> > To address this, call exit_files() in the end of coredump_wait(), if
> > MMF_DUMP_MAPPED_SHARED is not set. Note that early unlocking a flock on a
> > file allows other processes to lock and modify the mapped data protected
> > by the flock.
> > 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index bb6fdb1f458e..70698d06ec9d 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -548,6 +548,13 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Early unlocking a flock on a file allows other processes
> > +	 * to lock and modify the mapped data protected by the flock.
> > +	 */
> > +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> > +		exit_files(tsk);
> 
> This doesn't work - at least not unconditionally. Tools like
> systemd-coredump or apport go through the fds. Specifically
> systemd-coredump does:
> 
> 1) /proc/[pid]/fd/ — opendir() then, per entry, readlinkat() to get the symlink target.
> 2) /proc/[pid]/fdinfo/ — for each fd it reads the fdinfo text lines
> 
> The blob is attached to the journal record as the COREDUMP_OPEN_FDS=
> field. So the open-fd list is recorded as metadata, retrievable later
> (e.g. coredumpctl info shows it).
> 
> Also, irc some clever implementations use pidfd_getfd() to preserve the
> files from a coredumping process to preserve them.
> 
> So you break all that - and only in some of the cases which is really
> opaque to userspace. That's not acceptable. If you only care about the
> case where you dump to a file then either special-case it to the legacy
> file coredump format or if it's generally useful make it an optional
> argument that can be passed to the coredump pipe and a new flag
> extension to the coredump socket that makes the coredumping process shed
> it's file descriptors.
> 

The claim is the coredump takes "some time" without specifying what kind
of window is it (seconds, minutes?), nor where said time is spent.

For example it is known that a big mmapped areas are slow to dump even
if they are sparsely populated.

So I would suggest profiling what exactly happens in this case. It is
virtually guaranteed the time can be shortened, but it is plausible even
with fixups it will be too long.

Which brings me to the next point: the issue is not strictly any
particular file is still referenced by the target process, but that the
lock is held on it. Perhaps it would be perfectly fine to walk the fd
table and release these here instead of much later?
