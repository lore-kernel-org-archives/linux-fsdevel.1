Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05438E8CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644721; cv=pass; b=dA3y8vfpPA633Qns5nshgl4XO9+T+C3MuDx2il254xVmGDpihezMHJBJsFBZq6qsBnb9sOQwORP0cYIywaaBOH49D39b+lCRfNlbZ1chmOxP87ShQAI9KfTtAbUq2E7ntiNiW8VlMgJV+3MkZzoERbr/boWQs1SPuRrFa+zP4qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644721; c=relaxed/simple;
	bh=40b0mj9LccqvykOYFJDhNVL9/cfh3wCIRjlfxH+VtLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf8cl5jz0VZqwe2/NOnjFky+lEXge4hIqf9eaxrjbsEJZK/qxMrPHQjrXyifpqqQVynN12YM7yEXgUjYfCJaSCrD/zvrFhN/y3jnHN1SoATiH0Vhb81l4zXCsQO/kU+e/7HPa05AscnKKgtqxS/XSaOvDRgt+aS/NM3caOrCrrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhKG9E82; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhKG9E82"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so92a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778644718; cv=none;
        d=google.com; s=arc-20240605;
        b=Xvif8p4pSbmMXEV50wNOyXUErWoCIvCc1G6oYX39GcJ5y5yvMurUsG1E5yA9jRoyVq
         tq+D4XySeu6QIYjoSodYH9GOVHGOhmHh0DhvARBCHqTnRnDuF1p+eobtOZE2RTbFlFFV
         bfEvF/jZZ/PAmVFAGC0AjJlbCl6JIVO09BVXYLEhRbqEiwNGLNjhgM0Klaf0HHvTsPUX
         3R7rYOs+mKpg94+zEb5qVy2+6ZsX6b3jllfgNzwG9b/LPg2vOWbMVDS7fxB8zv98IHde
         nNtexg3BclwInkqOBvE+zPFyJejZVEihcS/TfdNV3jfXh1wP5CeF15e/N8bIw5+K7L28
         jefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40b0mj9LccqvykOYFJDhNVL9/cfh3wCIRjlfxH+VtLQ=;
        fh=WyO1yaZCmk6PH5POeMriMZJTDFfDQfPIBGqfmo1FBf8=;
        b=Bxgu1eX93vVkPXBSU7z+Z9lKQrTzUmZrE71fIh6DY1lYEZ5Y7MWMhUmc2+wn81I7S/
         V2lWTjCyKrN4IIpmpHGiWViSJkEK2EYkUi/Brc/JunW1e8YOlSKiJT+u76J5t4+Ntr9c
         /4gKATd95z///9AJrtMLdMaw8xONQcqMMnEi5PZHrrDFqHNZCJL+NTC/COAWxgiA/nM2
         Z8NkcxMROWBJenJkpqVruhGxRNEiSRIxtNN92tJyypz3MPkmQZhiNO6b3NRnL4qS5PHp
         xM2PauoVdr3IY8EhzHe/9uXOT5YiwTvBjYFGpoyEnn7fDHQWzqMmLnzEwcEerHdaKaOu
         rrSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778644718; x=1779249518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40b0mj9LccqvykOYFJDhNVL9/cfh3wCIRjlfxH+VtLQ=;
        b=RhKG9E826BMslqvMYNZZoYjgM5RAdS51NGBUgDWbrOiFYAjvnV5337BQftnqXJ2c23
         tSoc71oYJsGOfI8TJUdGxradUDVhPxEU8WgAP9y4OHKDxrRxqk87+uheOJ/lKA6DofKW
         z6teDznnZqJ7VPsXCQAVkmVHMQlJsRwVsgJWucRVvloSs+YbTrN9iuhk6HDbkRkDRVGw
         oZCw+KpFyQkN99zthKVVP0bJiu8aMTX4wAyoumJpTqFqsWTHpubhBGYPV8hGDYzb+DTd
         khdjMtk+p1yO6CWBnSdrmtrn7s+VA3NR0/RkdXkEY18ByXlyWeIDikhB/ieCrfhqlJNF
         vTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778644718; x=1779249518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40b0mj9LccqvykOYFJDhNVL9/cfh3wCIRjlfxH+VtLQ=;
        b=NloZCl93Xpm+chW6pWJ1I6TLIgrt5Q124brweNXDqKirmUOI06ZwBpLYTXBkfg2ZGZ
         TY+dNIJjk7a4AiJwkJBiCCOdJUA1uiyMbhK0yKx/bFI9n8xb0R+KG94SyyUOG2RF5QhM
         OwlG4TcWG2V12lzLew756k9KiO1cNiTnfaXmVYc4OlkamDSOCQ6HUfnRPVgGJTUSVNLI
         pk6UmUDwOS9RoL94ab1x7ROgHOz1aQDHV6m/6lBsxbRFOdtf8LgKQWlz9l0PsFidOXKV
         KeBGBYZnnvCinqkML5HTGz9FPnbbGwtK1GF//6nI1E5UwQmAFA/7u49XMB1x6YlUtE6p
         VLww==
X-Forwarded-Encrypted: i=1; AFNElJ+9Tzt5THHrRA18G21pt9L18Fmf9FZRnd0lipLjCy5ZKcv4G5K1O7RpaTDFzlXqGf5FMEG+XPNVLbI7L6P1@vger.kernel.org
X-Gm-Message-State: AOJu0YzmiFVfBLFyyCBqDMV49qGmHdJpFDZ54ago/FXytQyrb6y690OV
	NVGdMVHWuFP9nRdlVfNonUAnw5JzqFTTN0c9xGb8HzZw8z29EQES4SGgIwc2lMJaFX5fFEDsQTj
	D7BexXuTVSm5q2Kr7oDBb4khGKHZtQDYgNPvojBWl
X-Gm-Gg: Acq92OHX2k97PmJhExk8a+53OMdSrpkkFOhYJbzY/1MCvjuwgDMgJAofsWLdXqA6Uig
	KcI99L7u0ADKjCjBnI1/0l4tKN4nt/3iqP4s2c207CCkKhJfvWuTKx/ofTeXtWC4/m3173m2Kt/
	fufctkNzwjSAtLV/hGcMLXZ3MhmXhQF/Y2gBy7G1en/RWKVCpoKfi6tP42AV9x9VDCEAyer6nNA
	vyG5OcRiHaDnxbjkaXAz/euj/wjUR2PEoL5cgGtIhHvsP51aN0PK2Gf7K/QWgXqH2rZ9TqPws/5
	3P/2kj6JkfZaYBZj
X-Received: by 2002:a05:6402:5050:b0:676:67ec:abaf with SMTP id
 4fb4d7f45d1cf-6827bf5f4b3mr22466a12.3.1778644718024; Tue, 12 May 2026
 20:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426062718.1238437-1-surenb@google.com> <a27344e1-6f0c-4686-99ac-fc2cfcc5bb06@kernel.org>
In-Reply-To: <a27344e1-6f0c-4686-99ac-fc2cfcc5bb06@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 May 2026 20:58:23 -0700
X-Gm-Features: AVHnY4JDQcNVWDMwH3pin_nHYobX8urPy4XDY6wH_-41pJ7n237CNfSG2kbeWQ8
Message-ID: <CAJuCfpG3xZhL94E=yR1KsWs6fVwcdoAECoOaV3UOeB10TXmOeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] use vma locks for proc/pid/{smaps|numa_maps} reads
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	vbabka@kernel.org, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, shuah@kernel.org, hsukrut3@gmail.com, 
	richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:28=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/26/26 08:27, Suren Baghdasaryan wrote:
> > Use per-vma locks when reading /proc/pid/smaps and /proc/pid/numa_maps
> > similar to /proc/pid/maps to reduce contention on central mmap_lock. On=
e
> > major difference between maps and smaps/numa_maps reading is that the
> > latter executes page table walk which can't be done under RCU due to a
> > possibility of sleeping. Therefore we drop RCU read lock before this wa=
lk
> > while keeping the VMA locked. After the walk we retake RCU read lock,
> > reset VMA iterator and proceed with the next VMA.
>
> With many small VMAs, is that overhead noticable?

It might be but the point of this patchset (and the previous one that
made a similar change for /proc/pid/maps) is to reduce mmap_lock
contention, not to speed up the read operation, which is not a
performance critical part. The original problem that Paul McKenney
described and which kicked these series of changes is that a
low-priority monitoring process reading /proc/pid/{maps|smaps|...} can
block a high-priority updates by holding the mmap_lock. You can see
details about this problem and the numbers Paul obtained with the
previous change in here:
https://lore.kernel.org/all/20250719182854.3166724-1-surenb@google.com/

>
> --
> Cheers,
>
> David
