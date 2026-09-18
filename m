Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC983BB9FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744667; cv=none; b=TBuUNrQzdrVt0sJfOeMgZ8OhYiLdkiiJjgANVlS5MeeRNOrE8skuryim+OpsKiSN7XzuZ+vXONtJtarNxvLAs9EvkIQNdyqoGTeFjObmtMO1UFfRu+9LMZ5g26fOZ+JZ8XD7cukJU9qBR/eJWu7VY20T5OE+f1PfiepTuBMvU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744667; c=relaxed/simple;
	bh=lCzf76+NJFiZBWowe56JipIaRmY6y097OMCOguKq84Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBPhaTTDF0r4uybiTEFEOwHO6OLf6bVwIzsQQb08x06WdQqnRwXgno7QmM26MEL1zF637T0kVdgb5egKhOc8S4wnsnRzjmtfVtEON2eQY6DrX7ST+BWwUpkJgpeDUOuWJIJDjBGc53vS5PJvqkrIBBA9ylCgNJNla8jLO0OwoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAau96Qc; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAau96Qc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so116703466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789744663; x=1790349463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7cqdA0O8Ahj4mmcXHJ140W7PNv8oloRpbbh1DU0ab2Y=;
        b=MAau96Qcy437Rhkb8qb17CTu/aCU/UUHNgKUJPbxMde8RMu3sRQHlxHTf/cb99qzY/
         O5jyEgt72sKg5WOvC1qFIwrRrZ3/wmt3HXEZ09Oht9so+sUPKzIICQ9XaogQOZbqdBL7
         zEDreqNkdyjdcz38U2FuWBJk8V5R8InTTzk8DPBi/O8z6jd44XWhbxbp/6SgZq8Oq5vq
         l6HrAkyumm+GZM1a54A2T/uscFhJzQZLmnG0LBKJbWKKhl6qxLorBEkg3vTZyxwaIHkd
         +neg5o1voE/b4rmCie9MACURh8yiBzvFRLtWRFKp33u8QoCYYvDJ1EZHBxXj6YIWzcE5
         /1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744663; x=1790349463;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7cqdA0O8Ahj4mmcXHJ140W7PNv8oloRpbbh1DU0ab2Y=;
        b=JuOKpeMATySKBs0Havh1z0ichUdgbpVs8WD/FJSS+X9Tvocxo6I00YkiA347TFFtQt
         U5v7WvICa5XimwbsZ1OQCtCuYM5qxpyKRv/myaok2v5egVuHmiUmPy31XP/S6TX5assu
         +WlJE62Tn8+QXHWkN9uSYz8gMVtm4vNW+p/Ef0fX0eNBOlz4AAH8Iqlaj1e7q9pfAoDA
         Ma/68fHGhJXLc8CjfiJUcuwFWnrTppOybSxWFwxuojKJRVDIii1BAZh+e2SQkTZNaytT
         4U3JoaoTNGOssioTLPtSKCjmGKU3g6O7mdVG9lYLW4pgmW83OlL4LvZRVoKhQ3lI+rMS
         2sBA==
X-Forwarded-Encrypted: i=1; AKwUvBxDG0FKOBi85bxeTu3F9RvTzHE11TKkcNvd1EaSNmgF7sY099E1WtUZwzJXuqSUMH8KM30eTWfHC5HNP1qH@vger.kernel.org
X-Gm-Message-State: AFuF++njGCo+3R9M+wUE6IM0mOflJHnpe+ZgwBMF/LkJ7Npmffcg5v26
	VCRj5UwNq7VOcppN/YEEI57qUh9qWS5EUUaYQC/OZFEO2wSV+w2P4a5/
X-Gm-Gg: AYBFou3s+5o/200/AHBSUHXId7iWa9QHoDpc0Cf85vXZeZduOvvs7ujgIR/9oCqR/XH
	bqZ0M2aUFCq3jIMSQsSPFyYcSrcvvn4bkislwB/HOdC1Tm858BAD0XZ1s82z0k/KN0CfVSeRRYv
	z2AkGx+kPDo/TRNvuh4saclQRfoK5GQON6kIbwL020fvi2lYtRCRnJ0R4ATygOEKo8EaW6zC8AL
	JzFB0c/hxvzoDSziuhDR3Dsg5dX89BP/lhf90yYdOieUaSOohV57FBWqDxPbkrzXPC+EfsTkPhT
	RFyA8/oW+vv5GUfxltHyM1iNBlyi+kdr32NTqMdxuLQZcSfvzUJBRT/3YoNW9c30itTpPFPWawI
	SswqP+4Knb2jFwwJkz4MVJs531QnMxjTKr+pJM+X2qj9XMcIzw6PSGSuZ6Bm+2I+9SEj+8AWTbc
	e5QVjKDLMz4MvWiIIoDlvbjisy4Meak1d35id9QErr1KMclfXU5K2BNrdQi1E3TrSQJoVdKjF9m
	HdrwDW/P2X4xzcV4x0rbDia9jx5pPG3DXGI
X-Received: by 2002:a17:907:960d:b0:c29:d3ad:4f72 with SMTP id a640c23a62f3a-c2a157da677mr272170666b.16.1789744663392;
        Fri, 18 Sep 2026 08:17:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bb42643sm74893366b.26.2026.09.18.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:17:42 -0700 (PDT)
Date: Fri, 18 Sep 2026 16:17:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Mikko Rantalainen
 <mikko.rantalainen@peda.net>, Rich Felker <dalias@libc.org>, Matthew Wilcox
 <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, alx@kernel.org
Subject: Re: [RFC PATCH 0/1] close(): stop exposing non-retryable EINTR
Message-ID: <20260918161741.1d95bd4f@pumpkin>
In-Reply-To: <lhu5x02vhtk.fsf@oldenburg.str.redhat.com>
References: <20260913193815.2862366-1-mikko.rantalainen@peda.net>
	<aqcmz5uI7PgN5CT7@casper.infradead.org>
	<20260913235145.GY25906@brightrain.aerifal.cx>
	<eeb50cae-87af-4a40-b9c6-f4fa9981425e@peda.net>
	<CALCETrUgLj4Dz0s6PMofViJwausRWCvNvJphxWHUeWCCaRBtQg@mail.gmail.com>
	<f61886ed-3026-4db7-ae22-b882264141bd@peda.net>
	<CALCETrVnE2unnjHokG=bGLEXAeC0U8QRx_wb8fQDh-Fe5O6PBg@mail.gmail.com>
	<lhu5x02vhtk.fsf@oldenburg.str.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 14:56:39 +0200
Florian Weimer <fweimer@redhat.com> wrote:

> * Andy Lutomirski:
> 
> > I think I mostly agree with your analysis except that I really don't
> > like the ENOSPC.  The kernel actually has the ability to commit to
> > having space for pending writes on an fd *without syncing*, then I
> > think that capability should be expose to userspace.  fsync is a
> > pretty poor alternative for code that just wants to make sure that, in
> > the absence of a bug, crash or physical failure, the data won't be
> > lost.  
> 
> It's something we might want to call from fflush.
> 
> As a replacement, dup3/close doesn't quite work because it releases
> POSIX advisory locks on the original descriptor (as they are per
> process, not per descriptor).

POSIX advisory locks are completely broken by design.
They just don't work for threaded processes at all.

Thread 1	thread 2	thread 3
open
lock
		open
		close
				open
				lock - succeeds

The same could easily happen if a single threaded process opens
the same file multiple times.

David

> 
> Thanks,
> Florian
> 
> 

