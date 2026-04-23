Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2C2EC086
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984520; cv=pass; b=UtHanMyfpS4myx+cDB15Iznc3SzSXQkvbS78doCW/UqC74WkqZtOEhKmNuw2hFC+nvnVNxR7cUrapVBWoNW+XnYYVSjicKrFmNW58vZ0HxNjcXLv/04NUL8NJT0apeGR2Nbg0VB773baKBMry75dYX1AIxqGrNGzFWZcufrwj1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984520; c=relaxed/simple;
	bh=PBzYzzed0a2OR9Q/3+hlr1GpG5Ca8dqomaAx33odVBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OokEes/VjooPB0MpzG7YXcSuVx+Q6btEvX8dCpileFhLtSYwU6MVVsEAHbc3bejL16cj6Mmh8CWCeVH5/mouH9tAyyrdN7t1aXz8fxnph3yW4W09Wcg49Rrnmh/Y+mWYSzm0nK3jWg9MeVOQboaPZ+1eVOa5adtWUthas6Mu+XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZKA2GuO; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZKA2GuO"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9697so58172c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 15:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776984518; cv=none;
        d=google.com; s=arc-20240605;
        b=aaJP5k/ULbs86v6dVY7JAVoOjSsUOGmbMFKp7wWcx2PFqYY9eKimcJ/NLCGVH7v5QU
         dS2RJ9LPpTiAJQckQ95Olr911FCc2w0e1nhx3FyBHBnds1k+YRA0AcLaoKXPJWqGZRTp
         kcNSycwp52169nYIeAeI+7Isig2syXNMmyrAgTDuBhP420+IatIs/eftEXs2+zL3gls4
         jw97BI39YzDtjaiUpSfJgJz2rvlJ2aDPfpR4Wcg3KgWdU2D6SUaJg8Lbc5lAqxl6gRur
         9vohLLmOmnG0grarMqLzNFsCqVMRV7QbSqjrli17bEWcaOWg39YlBxpM2vBihjdPlo2Z
         3Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdpbEPr8sE7aTSdr+qiHK/yc7hLSV1LYoXL5XQUQfyE=;
        fh=ZU/ZWQCXh9BqdR7wrgzhuv3Ysm2CfBCtRQIybfVcj9c=;
        b=gUmAH+P42OycFq/YyYKVKCoN2jluY85qykKHu8qQzp8k/Lbw0E7C2rqGufGh+C0gsZ
         YlBvjjlQ7m1OZRjq6b8xlau7GexpMGlU/B9mGOv0fApNbBwxt23lspu62DpDQlZ7l+gy
         dnBXSCMubeu8sR4zZE2s5HAZPeTkWl45PBGssA/LKaQ7iTxcAFVqIN4WuPPuY7lFDcMu
         tFmVDeqFVKa26cJ9Mcw2DpUy3XOOspmufKqqOfH3DnxJjPsLJ0IOU+jvJ9BSEri4tctl
         204CHc6mqiG3savwYIlEIigSj1SvTSNcLPKgmrJkzkDuDR2+2ftg7uhjnGpqhw1srDJl
         hBxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776984518; x=1777589318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdpbEPr8sE7aTSdr+qiHK/yc7hLSV1LYoXL5XQUQfyE=;
        b=JZKA2GuOpdqkqOluxiB5Soy2AuCeE76DgnrsgFkfss7CRXJ4vQiYPtIDFLRrgQZPda
         1oRfblFW/qXYw4JriL3BPHmOfpoxWfl8TEOQlwk5YZ8QvhMcUTimY5U2JLunFd/3eEdV
         X2nIAmMK1PhUHl9pcTv/GwC5WAkF0DOV9Oi5d9sCDMt/aKGHl/OI9LLlbmI4SKGQ66r7
         q3uNNYujF9XUrZzxmpxOBq4gbDTqM4FhtM917AF816zX/F3oI79OQcbPu+ZqeTl6wOXp
         h6UqfW/dDF/XWDJfxl7YqQSRXCgKp5DhwCHXBvi6/fV9N+OONbFIMnYgDgm7qhH9tzNP
         QcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984518; x=1777589318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdpbEPr8sE7aTSdr+qiHK/yc7hLSV1LYoXL5XQUQfyE=;
        b=ic9biJOH1nt4az0vfs0rkOVCr01yrHyyoYyQrvnKFW4tWaRmeAjyFEl0Ub4fKKvACI
         oRKbt6EBlOFk2z+c7MpEdfYSZrYpSDMZ/J5HHkouROozjcSU46ZGCTPF+BJCzbJU6tZb
         D2SxZjDfW5SYbMJhP012xDWW4efU+2lO5+ajqZ5EoC5GoIFK38G0fj4rGtNsoj6OtZ1X
         g0oB7EzxkZ4v8stVBz9LDlyNcXph0U5VnHbO+wzcNeGO9YexqCkOimBj9N5qx/y3zckJ
         Y8EoNPK13quCZmWQh/rSPWyQRcgksfAOMgIv1RJIiC5WoHWLG4qvJjmn5E0RhmvTrri1
         SX/g==
X-Forwarded-Encrypted: i=1; AFNElJ/P+IawzaR03cuEZ+uMofpR4hV4FYHFzgcwKR3YxV8QO0f8MjhaclFRY+qmaypW4/2nVv0x9HlIolSKB2TJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg76HA/3GHRGJHtW+PaKa7REZY+zVcEd1122kHljg9tDtuvnF2
	3zXlZAtc2oOYOJoPhBAZAJhOLgiiVZMOIY/DNwj5uJxE8rs/eitDguEunzgy3Tk2DKBB1kpKDIX
	BHdfpzC+kfyoV3B3eXQct4rJx1MeyaVRMNTWHg3b5
X-Gm-Gg: AeBDiet6lWJmUr2JxKU89Gh5MYyxLWsE/kVL+0wL3mVhDdgzbYEY26/BJUIKMiMX3L1
	/ifqcJA7X/FixR3twdrPEKV4kH4/GjXSrkI/PhJC6EiqufLS6TfC4n8vb8lyyHtEoqFm0cEyw6/
	omGPoTXhvL+OeQLYK0s62nlOIq6izpmZFT0/fb7RGbAaTBbnCHr9DK6vNoRhp+y932UDwft1V+2
	+YIEzIL8UQ3rJz3G9/8PqYeWpFVZDH8XvVKxJ4s5CxgWkK6zzO3C8YjyXvo68xZV8gIl9VOO2Eo
	y5KHk/de1xltUzHJhSHRQWNM+V8yBTDwPFY/72X26M9WswGh3x8Pp3qEink=
X-Received: by 2002:a05:7022:6b9d:b0:12c:61fe:fb37 with SMTP id
 a92af1059eb24-12c7b258b49mr945598c88.17.1776984517927; Thu, 23 Apr 2026
 15:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422005608.342028-1-fmayle@google.com> <aei_d5KMKmLhMx3S@casper.infradead.org>
 <qmojyvlsbjcgavnecbvfwax6o3d7edzifpxp7raxbevbfcxtbi@mox2z7njeodb>
In-Reply-To: <qmojyvlsbjcgavnecbvfwax6o3d7edzifpxp7raxbevbfcxtbi@mox2z7njeodb>
From: Frederick Mayle <fmayle@google.com>
Date: Thu, 23 Apr 2026 15:48:26 -0700
X-Gm-Features: AQROBzBKmc7DAAss2RftthMElY3qEGGKztQAKz3HOJbiVkmJ3gzR2XQMGvOzSpA
Message-ID: <CAHCxdc6BUtT6Ozdpas0+7abksrR6hM17BNzz4=rsiTka0vxVGg@mail.gmail.com>
Subject: Re: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, 
	kernel-team@android.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 5:56=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 22-04-26 13:30:47, Matthew Wilcox wrote:
> > The problem is that we might (for example) use mprotect() to mark a
> > portion of the file as being unmodifiable, but nevertheless still want
> > to prefetch through it (since it will be read, just not written).  I'm
> > sure this solves your problem, but I'm not sure it covers all use cases=
.
>
> Well, I'm not sure whether all the usecases are covered either but is wha=
t
> you describe above something you'd expect people to commonly do? In gener=
al
> sequential reading through mmap seems to be already relatively rare...

I'm curious if anyone knows of a use case like this. I'd think that, if a u=
ser
is making heavy usage of mprotect, they'd be advance enough to be a step aw=
ay
(or a few steps beyond) wanting to manually trigger readahead with madvise =
or
similar.

In recent history, commit 38b0ece6d763 ("mm/filemap: allow arch to request
folio size for exec memory") disabled readahead for VM_EXEC mappings and th=
ere
doesn't seem to have been pushback yet. Of course, non-exec mappings almost
certainly have more varied uses.
