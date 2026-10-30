Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381457;
	b=bEEKqW/yjFNgSbXTWFFTyWYkmDzF40h0oCvK4f+5vQSEf744zLKS93E+iVdpSp2zxbV1
	 EKa5jfia8xf9rV/zRBbUsyipjo+fXfXpaIeV67B/pXHYebSR9OJ1KiDgH1Po0f0Nv8r3x
	 tgjnMeuMjEWuX/YegIfBYG01uVsHBlBOm5hdp9fSF9zdSlQq1DSX+MAWdnpg/K2MNlJFl
	 2dXN1KqFmEbQC1ONavTDxO8dw+0S6A0dr6QJNH/ECS3dV77Qo9Gjivrwl+NRRO8CPURvE
	 Ki0nlNJIhMlm+U8TYm9LKL+Q7WkdQhPsdqOWWcIVbS6YfuoPKCnvlRT3AtfYQehPT2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
	b=5Qws+agd+opVFQSZwZuUBHoepmrQQbUogzm5KypdXuGlWbGaF9QFaI+N7jvKK6hz3h0i
	 2bWkXnEjM3pZO0I1SV/N58bHEKVHPH9ErcMcbsNqgBBNFf1kvvjTo1KVg2fq6JKnxBIaH
	 S90w3D4aXynDFTwzfzcA6KmwWNJeX01iagwtSPzoM1PLRDXx3FB4LkAc+yzpuj/vggkHk
	 RnrcQP22Raa3RCV1x44pJQo7XbkL5nS7AuSuykU1RVfnR5J5q+UaqUvQaJd0t79JcmRS7
	 uP77J+GDG8pT+PxcLZq2MXw0IY+K3sn14OZg8cbsUucF6wJ/qli9xZg5I8EkmSzxrRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRdEiK4a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C1606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 17:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A6C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YRdEiK4a
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c423b145922so125733266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 10:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793381455; cv=none;
        d=google.com; s=arc-20260327;
        b=oy9OU0dO237bgEzT2J35VojuLqNwBTumG4DrnU+HvF3qR+IR6B9TR15v7+WLnJa7hz
         8ERDzxqe3HQZAQlKbWFZoEvmoUQLHA5HzoVcpYVuc9IfT1Mr/xpjnTplapidFp4/Tq19
         2XhXBNwhHlldB6L4cSuDatSSt7tYsy4lBu4cbH3M/c2t2QgchwHWHiz+BLGPKBNeMLVG
         oXQX5ECapxjZHzPmLihl2MhIuE3ixJuRo3XyS/rO28l+t+AtbwsT/VKDti8/L+Vxd3z/
         AE+ITxT4CkzpYtzOGHWwvdiUGsTBD1v3EQcKUVZ/5kHtvkk5ThTgWWjLwvY//SQQd98a
         Ahpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
        fh=/2iwxPlT2ulPokLomUjfbyGoY3aipZQ7VPf4WJQej6c=;
        b=JfyC/h+0/tsUIdt4Bu98vmsBEIfABOVGpRUQx7TlO+AWFemO5JJUK0SSaqAvByF4+j
         E3KTQKSnthUlmYP7f+4VN+QKkTAkFhV1W3cgOuSlHW14oGEGXV1CNBYR2pI8sMwTGXtM
         ITQA+f38vWnJpWvyBnQHbkZzygdXs/S6i5R/QbsPGNqC7xv8qJW93p0n27rnGNlFDm5l
         RO1xH1sA+t1lvcdWt7710GACeKCiYk7K3/AyGJlHKrzHr4rTg9aFCKzACjsJgoLnxFVV
         f8QuPuVVr8XIMxwCvULidWaW5Lq94Tk87vGdIQfVchvBxicbl4+N/5KtGJqsP9db/YOJ
         QxXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381455; x=1793986255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
        b=YRdEiK4aHv0IKz+7u7fp5ep1462g/b4sOcJcYatNtC8f3nbxEgI8zbHQI4kQGPOENY
         lHiSkxaAh/nhc7G79xqM00CeVa7s3S8n2LSmHkbq8brGiC18aBJq7VkLsTNoBvWmBJzV
         wkI1KgqpI3WMAV6FnAKjtw/pGcgU9WNDP0afdqf0lzgbprUqT9LIgnKVPw0PIHqmUY9N
         Zt1jfM0/DWvHrXxO/1gICi+3DPsvWqLMDtD+Hm+vuxkvAGNTX342zXWV4dhtIlo3aIoT
         ckowu7ofPwnUFBZFPYtv7PcxS1ps34LpFFFrse+O9504n0cFt01IYJK6piM7iEXQdOfv
         4BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381455; x=1793986255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
        b=mlSd82HY1fwRodrMhvGBVBmWC0o1/kky2eRNnJ+r+EM74NE8dWcqLCdi7kiBliuYyD
         iUapInM/p51NKHYzIljm+t1fhxMVGEI1CtY5sUINnm4cC73sCvOw3/L9SLts5CMI01rm
         /UBLIC7SpFNdB7KX97x7E/jl39rS1QP68RbJmKC55gS1KGxb8mrcbtzhpp8SN8qjnlii
         q8DMn3s1po6578EfXGkCsQMrPFDopQliUQxa2v3/+KkP30t+sgzH5kCli8tMuGR201rq
         LSa5ni9bJFvyYS/eQwpHcWCH2nO1QKyH7GwSdcNHEtvop41qOnmhVu0BlbEezwsvs2tl
         8A/w==
X-Forwarded-Encrypted: i=1; AKwUvBxujM9aONofEPWaYSvNJVEUKNip+TkiRbA6svYeGo9xhcH3XDY7tJzrOcFI3n5D5aEG7XwDA+wUCst5N5FC@vger.kernel.org
X-Gm-Message-State: AFq9FYKT+W5kKmaRwV1iFNnhKvZQXVFEahLrY+ieaNaQB04GnMW33fP7
	IzDobG4+QWNsBmFfv+Zts6RyViNZKvDJ04Wg/1pgkWrc7NFLZDIB+zFbf5i4qCzMmoKP5CQSeqx
	njH39i+hhal88yTxAeytuTAbc6oDzlkM=
X-Gm-Gg: AYBFou2teoS3wmxo7m4NyEcy6dMTPNShWXRh3CNYLIqcJ8gxo+IUqC6nFjRmvYWEiZb
	qYa67l844ijNOJX4y7dRiw3TQZEqsyO+q8TCZ7nQfrXWunEqmYvd12cBLslk0h063RZSDmci0f1
	eyxlPkpjV/Gn7G/cxleYNFqcNKMe2CxZE7rNnJ7roCL8LlJf6w2z5ylzrDd2W33Dz/gFYMUzo2u
	Z80R0Pl/UtMFg+vxeZDrimlVANcJnycovabKCO3qw2lL2w+y46NDBGAdU1e8DXpAhQcqjhZRTcB
	mzV7CAw9wtXzmg5Tu9QIXbLq3XXk6UtJ0BAxsOectOEL0xA3SQG7nWpkZkzA3+hUTryiMCxiiX/
	4e5ZX2TxlwFybbol0cbGqPo9xkLufU3zYfrthpRlPmbfxfOSCZd1jcg61KLw0ryu1DqSp6w==
X-Received: by 2002:a17:907:9410:b0:c34:1ed:54d9 with SMTP id
 a640c23a62f3a-c4ca795ef4amr303423766b.4.1793381455246; Fri, 30 Oct 2026
 10:30:55 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com> <20261030170603.GA31132@pevik>
In-Reply-To: <20261030170603.GA31132@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 18:30:42 +0100
X-Gm-Features: AclHuK_Hp4PUqOVNhv7EARHTCHlyz4-aNYuu1zXh6K09HqFHmjVBq4i8xeI-CkU
Message-ID: <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
To: Petr Vorel <pvorel@suse.cz>
Cc: Hungyu Lin <dennylin0707@gmail.com>, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 6:06=E2=80=AFPM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Thu, Oct 29, 2026 at 10:07=E2=80=AFPM Hungyu Lin <dennylin0707@gmail=
.com> wrote:
>
> > > Queue an unpaired IN_MOVED_FROM event, followed by an IN_MOVED_FROM a=
nd
> > > IN_MOVED_TO pair with the same source watch descriptor and name as th=
e
> > > first event. Watch only IN_MOVE so creation of the replacement entry
> > > does not separate the two IN_MOVED_FROM events in the queue.
>
> > > Affected kernels coalesce the second IN_MOVED_FROM into the first,
> > > leaving the IN_MOVED_TO cookie without a matching IN_MOVED_FROM cooki=
e.
> > > Check that all three events are retained, the two moves have distinct
> > > cookies, and the second IN_MOVED_FROM matches the IN_MOVED_TO cookie.
> > > Cover both regular files and directories.
>
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
>
> > Thank you for your patience with my review
>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> Thank you!
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> I have no problem to fix very minor issues reported by agent before merge=
,
> but what bothers me there is no kernel fix for the failure.  If I'm not
> mistaken, the fix in kernel [1] was reviewed [2] but not yet merged (I lo=
oked to
> next tree as well).
> There are other fixes for 63c882a05416 ("inotify: reimplement inotify usi=
ng
> fsnotify") in stable, e.g. e422777fdd474 ("fsnotify: Fix stale object mas=
k after
> concurrent mark updates"), but I haven't found this one.
>
> Merging test helps kernel developers to test if the problem was fixed but=
 break
> for it for anybody who uses master for regular testing without even expla=
ining
> fix is WIP. But I suppose it will be processed soon because stable was in=
 Cc,
> right?
>
> We have runtest/staging, but that's for new functionality, not for tests =
which
> reproduce problem which was not fixed.
>
> @Jan @Amir is there a git kernel tree for fanotify and inotify? I found o=
nly
> VFS. If yes, please update MAINTAINERS file.
>

FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
M:      Jan Kara <jack@suse.cz>
R:      Amir Goldstein <amir73il@gmail.com>
L:      linux-fsdevel@vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
fsnotify
F:      fs/notify/
F:      include/linux/fsnotify*.h

We could probably rename/move the fanotify/inotify entries to appear as
sub entries mimicking the VFS entries:

FILESYSTEM NOTIFICATION (fsnotify infrastructure)
...
FILESYSTEM NOTIFICATION [INOTIFY]
...
FILESYSTEM NOTIFICATION [FANOTIFY]

Thanks,
Amir.
