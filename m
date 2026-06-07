Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE292C029F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861537; cv=pass; b=b+461aw0nP6lJaNsEkyUYBcuOBKXajtCx6F91IzEBYKSgrtAtfqSwJhkIiCBJtpaN9ud9NLJzATqvG0YImNbjkSav8YV6x5K9K6h9a208NoKlz078gt0y4PZrpiAs3RG9cr+/f/fIytfYVQo1EyZbDNjPKyuF6fY2MBmlu6YeyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861537; c=relaxed/simple;
	bh=WonlPgUFHgcUs9L2FpzERLFLGDIi9P0mv3+MIWNU1M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2AAsn+UEVPtM6qczIW6Ud62QujiVIS5M6vY43+tDZOy2Fhek2sU7GHLOx1Sue373hvX1NI8TEOZVrQMyRRepqqR7K9C2pL5W4ooLHxA+JliTSiw6bc+1yNy+7TV6tlmK5DG6Azk9NGL4RmVlOZEBhBjMZmkWwa3iACely1y5mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEPPfSJ5; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEPPfSJ5"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51765331535so1314281cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 12:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780861536; cv=none;
        d=google.com; s=arc-20240605;
        b=SXz+GlhM2yzPVOd5nLvL0HkJpmvQp6juag5qn1xkQHNLCzNLbgcXRQIvCu+GQdRIcR
         ZAYzVTlfWB9Olw15SEW1UQvX65Jg3RgDWjEbiRZPl4ipU5AdldzzFNl2mIzKMuKV5AL7
         nurVjBekveZ0+2/HaeCPcHDg/uNw5YVAISEAyoDcBmhIbzZjHe/gpXaj8G9UrEqy7E4I
         AlSqKL9vsrqncvnYbuhCAwfo3cy5giIZmd5wcDQOCBgqTqX7DMjvxghQ2kF6YjvEElLn
         jQrza35NflPGRUGynhXcOhxz13ZILyOMxDa8QKqh4o7XUruVskmBmAxGSac8rb6DMyCP
         i5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WonlPgUFHgcUs9L2FpzERLFLGDIi9P0mv3+MIWNU1M4=;
        fh=q1je1tl96oEx+C1i+t2cdcRxTfjBqQlj8+fgnrOcVS8=;
        b=gLfJuVc3vekAUDfB5dRO74t2FYzhi5rfcCJ0d7i/lv+ykzS26sZecELZwScTFNpmGM
         B1ZYFUqlm56SpvOsE40/jAjh0xTbjdS+kA8WOnbpirSXJxi/Ypb/c+BFhcEhN/W11A6v
         Fau+FIkCIfPRh/M63UWJxAbqdRzLw/WAV+niBR36Gaw1l2CnJ1/+vUhUgBwQXHcdvgrN
         Rn//77hQudDjnwMX5HdwKiJr9HpxjuDKlpH+f5DJoMy34ZFMcnGxCmSVJAJLRt0rm13X
         D6dX/HEZ0T4RJvqCv8BkwV/ujd/4YRRTFfLbJfvIKcy0yJrXQVpa2jdM1Ssa3/BnsLfb
         D9Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780861536; x=1781466336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WonlPgUFHgcUs9L2FpzERLFLGDIi9P0mv3+MIWNU1M4=;
        b=AEPPfSJ5T0Dq1UhckF71+Gu4Lstai4Un9be2aFYSc+s9NrIvWtWXmCh7/WyiU336Uw
         zifPX836ktIFHY4WUR2M8KP4jC2zqs21p3cl09Xlqv3IwcYwGoHtCAVGB5D1C+j1wpGE
         tq//XD2DVnxPTeSHnF72jxWaXq3psOlVYwbW0oswNqLmG+5JNnIJX+Y01tvGDui7eiuV
         eEA26IpMHsJi268W/VKIhsJURN/Hq3F0pRSwG5BmkLfoY+CWBrhu1BYdR/8HsPUYMXSQ
         /577Jpe9GZ0ddbfEM3RPDhVJuzsOBtqInTLoKUoUrJdgDemDVwIgFjDRZE6JUS+JVtgy
         jGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780861536; x=1781466336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WonlPgUFHgcUs9L2FpzERLFLGDIi9P0mv3+MIWNU1M4=;
        b=dzhs0mh1xgoTHqJqDODE+YlDSiCNin1VBPdvwnv07JoLxOQ7XrXWahlXWsxMuzoOI3
         /K8pcgGQJUrFA/5fdZ+tXF5a/e+YOdgyuGcm8QUoEehOXqwBk5pMQCoEM01d6Ak7g2Rg
         COAQ+hOlV6T6rYWyhDUI3nURgMK+sqFv3jyG4RlFUFjK7f0KbRgUqM0RgX5Li6Cka3ui
         8ftq4FajkL+QgyNp7UMFajMNqRTA03pzp6X63e4js9uCPtRjKxYhQxTlplXR/hAMFcvO
         7I2qgUeFEsxdEojlQ4RJwv880+z8JdvHciFPtqrARVXSYxCVV70oTSIHBbihotg9juB2
         kPdg==
X-Forwarded-Encrypted: i=1; AFNElJ93OecYwwQBQC+eDX/co4HGQPNey4pbsJaSDQpcZFQXUeOrqVBOTIfqB4//qNePLkUBeTOOwZ/oWgjVvV+u@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlJSQ365/fw9qekc2ZZNJvagQLryAHhwwPfwdcauPf/TGVCy6
	HRAj20YS9DtUpAIt1M7utQu7DZb+zJG3/88S1I0u9Nm74+OgiEOeVgv26lH3US7YeZaLQYgEGnZ
	tkt8gsC/AcKqpD1GWislHp0RnyHeD7k+efc9Ts2j5
X-Gm-Gg: Acq92OEBOS2agCYkfzNkr04AkVtNYRcfTVpbCVUjB6ABul0qgqPiY/2ADgrzb9972qq
	PtY1BeQQateAd3DEOVfZ/l2sKni1moOA5UgzO3jnsyARKI16Jrjli6Ix/vL7hz2KA0GwIOZs9wW
	ASSoh+gmxZdPNRUxRJ6lERTRt348zzJRBzobmnRRUlxsA/hl6a4CbYAy8w47/BlDSDOGgB/Edp2
	PIDJh6e9lFsppKJaaHiQ+tXEiu0f6FjCe0x0d6QV7JDAKYL0q5yG1g8SioyvKvT1bsDQYxoncWM
	OfjVilicPLiRXynW
X-Received: by 2002:ac8:7404:0:b0:517:5f1d:9f7 with SMTP id
 d75a77b69052e-51798048095mr17306831cf.7.1780861535240; Sun, 07 Jun 2026
 12:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606015729.1837935-1-surenb@google.com> <20260606015729.1837935-2-surenb@google.com>
 <aiPWD6xZLg6g4DTO@lucifer>
In-Reply-To: <aiPWD6xZLg6g4DTO@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 7 Jun 2026 12:45:23 -0700
X-Gm-Features: AVVi8CfBcsay7fSf66Sk-qLT0-CR42bdtqU3m7RFkKEe4jFMaUgxiFQKjS-VLls
Message-ID: <CAJuCfpH74gRmgm2tgwB7SHzL9DrU3Yc4LyS8XLa0tR7fJqaw_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 1:12=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wro=
te:
>
> (Will review separately)
>
> Sorry to be a pain :) and I know it's a petty thing, but even for a 2 pat=
ch
> series it's easier to handle if sent with patches in-reply-to a cover
> letter :>) also makes it easier to track overall updates in cover letter
> changelog.

Yeah but the first patch is a simple cleanup of about 10 lines, and
writing a cover-letter for a single patch seemed excessive. Andrew
would have folded it in with this patch anyway, I think.


>
> Thanks, Lorenzo
