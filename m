Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3E2F745C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801536; cv=pass; b=fjUwEYhc47FY/9AAV8jWmVAYxebGED2hGB2lnQ9aP4hFdmk28WTArXDSfMZRUG9k4TRimn5QSaiSQb9CrDEo2NRI5QvSlJo4j3jzJBZZRHgiWqvuBNT0pyIJhPOVLyYUePNlrK9+7QEyjxzR/dBfj1AmcXhA+hyL4gc1rHBlxcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801536; c=relaxed/simple;
	bh=hMi7aZTxm3jxivWjZ700YzVjKsVqCe2blnMBeZ/az7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbfJzDPUCQHVMLZ0jpAgLK+TGbJHoTs/QVzDFp+jKcIwpja2D0eMSWNxOqAUcOMFheRd/N06Wwn9xnm9CT5f1oAn1V2AxGtu1fhRnJSQosmpsMwL8swVds0jbV/SZKgaCfQreaqjGYMWMZz0Ld84FJLML0X9n/w75/DQ+Tbbto8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1oifKG9; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1oifKG9"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5175d339e8bso1881cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 09:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781801533; cv=none;
        d=google.com; s=arc-20260327;
        b=AQWEb3dPmJ4JD6tmlY/2OzyOXfUhxPaadsg+gEVOQX5xVuM1bTOnDU4GYoC/fzhlHd
         Fn3Or5xLptY2g6rU6/BIOS1AsF31Nu3fSq5FEL3xLckEx7nR7C/qOZ5hRRHXv935fncI
         i8Uj75/30a7nisEzTXqgcVeGbcCVvN5mVxHtGregAYu0z+U1+fAtT8xGRir1vap0g+5p
         DazCnZlMO7pRyGUszp5zkhtH14HyhIjWoAhQKLTev5y1feBiMqRHw4UK/yV/MzXU0Dn2
         tZonIDMfYJd9va/Dylmu9Riix+kI2ty69HPHIi8qSZ5+Xe36sPJuunMnJqLlCPzFccqr
         Gp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hMi7aZTxm3jxivWjZ700YzVjKsVqCe2blnMBeZ/az7U=;
        fh=10Hbn9+SR9dkuiIIqt2apuzjzbU41GcadD6sg4qmSxs=;
        b=hLKwQOzFJgcWsLoB8a1dYevHMurkkHU73yoeLhCpNRL1Q0HFOIRU/JSZP0uNmecxJc
         Nwnojyhh3j7uutjaDAZxZKljJTe98T1CxSGdkUA4zWxdzZ07xx0Oy8LFGn7wf0o+myCk
         5DFNoxFhy2b1ak4s2zYq+4/XAlCKOX9sbNLFkenjd9BmHPEbMu3PNCafJ4XYlL9cWHJm
         850JVFc53V9fXmhZ3CuRInnfs16/ufHB6/dpmuA8Po4XCo03pWX0HZNzpe7JXEhW/VP2
         N1+kAqS8gepobar3sNEXrE953rbd+21m8BFB9WRyUoxmPjMKztg0nDY3731ZjZhiXd9z
         8RHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781801533; x=1782406333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hMi7aZTxm3jxivWjZ700YzVjKsVqCe2blnMBeZ/az7U=;
        b=j1oifKG9QC5hpKrfFPD6bUTv4CoOhJyenLZzAq0hT8D3HmEAki7KOb7VnbCFlyUeEy
         YYbbOvjufRaeiVGYY2E3IxZur43klb/Ju1EOZamx53Djji48LoOuUEW9RKvEq6g+I/tT
         5qY4AwxQWAoxSQ1UXXWGeP6c7vQNriW9qOgOvKKH41gGYhTZKT8AyO7RvZwvf8EE2xD6
         qwtCalRq2djywerEilqLOC3U1V7DRMztkzubQcccuvVcWRbv1X7OrUTLZlLss3aBGwU3
         N40doGHrdMNKqUsAEo7xIAQuD1w2L1AhaccJdd0+cwmDuRLwKGHtA25lj4jTo76xRXD/
         w0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781801533; x=1782406333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMi7aZTxm3jxivWjZ700YzVjKsVqCe2blnMBeZ/az7U=;
        b=lZzmobhTraoo/FEKn1CnWY4zWTydOYKILjxG+15XMaaygXW8SftRI850eJffKEzf2g
         oqfx0iZ8HLSYoiBEIuA+nvetS0tDCH5+Q7qc24hEwGo8Yk0F8tH6bY9JQjLwklSO2Lqt
         4C2uV35AeUkQdCloetQo/OzeULhYoJf+75XBgX3h8Rit2jbERQtjdKIyydWl1ryVv6+Z
         Nm0xTIT06jsc42TNLWhz3pV670m3/GNlIY3D6vzAcQBtgZCkfHKrxsiRKZvXjQ/DVp4y
         byXl50nFNCBzMfdYH11S9qwKz8Hs/g6sHqNcuu/MRpGQxKesPEXfiC6EoBeARlLm4R2Q
         vjNA==
X-Forwarded-Encrypted: i=1; AFNElJ+s3SMnobavZyuxmo716VQ3P7KCXlucROls2PmvtaK50cDAHY+UNzUDu0R9QExjmRELKHvUtv8YXjKISHPk@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSkYyk7Ds6nJHdSb/swEFul3iijYVZEUmSZOAQVMNQ3JAYg9J
	sQi6qK3gKJUfNm3heH8WVdLWSe5km4Z6Q+OmVo/yHpZTrmr6hn6SLzho/hf+M4LEkGWW+IVKNxR
	ZlluPhUZn0jXRJzpBFrL4H39p04qcduorNQZSZZoT
X-Gm-Gg: AfdE7cni6F7eMzTuH8bzTduNO3IcWiMZ61KFpcH+IQ2DB/LRgI+zvprhR8E6xozN4v9
	lGTdhjNrYOCRR+m9YCkriiK3HhrgmVkkBbogPztekDteo39g9I9+1ugfDPlOuk8+ytndg46Ctv/
	iJX9852xcUDb8zJlH6lhl7zYVFpWrZeh58cGwlDW1PJrNepuuthtfotyJNJwslELJVCcCEqPjRJ
	5dmWLmOyFVxOeTp+HyGBc/QyBGnAixZNNs+Xxgk0lmVpUJdrWg2Ae27W7vzhVZSYnL8uKAVxFzj
	1zPO14tCj5MPcICyHrDwa6w9rw==
X-Received: by 2002:a05:622a:2cb:b0:516:4f62:85ed with SMTP id
 d75a77b69052e-519c67370aemr11157381cf.18.1781801524859; Thu, 18 Jun 2026
 09:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202606181547.617a6967-lkp@intel.com> <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>
 <ajP_-zqVPtbzvc9j@lucifer> <CAJuCfpFed0GuMk+dE-Xn0w45Mn1Spds-pc2BE__FUoWm6+R7_w@mail.gmail.com>
 <ajQbXthzbr9xgUIM@pedro-suse>
In-Reply-To: <ajQbXthzbr9xgUIM@pedro-suse>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 18 Jun 2026 09:51:53 -0700
X-Gm-Features: AVVi8CdV8JSYSx61wMIbmgLKcoU5jz7qQB1U1gJgsDUd3AobdGi4EL9lK9NNRxM
Message-ID: <CAJuCfpH_Fp=J-m-kVZ3VVmqH0cAfNX6CQKWt3XmAJq1Rp9sFwQ@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second
 45.8% regression
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel test robot <oliver.sang@intel.com>, Frederick Mayle <fmayle@google.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>, 
	Kalesh Singh <kaleshsingh@google.com>, David Hildenbrand <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 9:32=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Thu, Jun 18, 2026 at 04:03:43PM +0000, Suren Baghdasaryan wrote:
> > On Thu, Jun 18, 2026 at 2:30=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Thu, Jun 18, 2026 at 11:30:47AM +0200, Jan Kara wrote:
> > > > On Thu 18-06-26 16:00:42, kernel test robot wrote:
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed a 45.8% regression of pts.svt-av1.Prese=
t13.Bosphorus4K.frames_per_second on:
> > > >
> > > > This one looks serious enough and real. It would be good to figure =
out what
> > > > happens in this benchmark that it benefits from the readahead acros=
s VMA
> > > > boundaries so much...
> > >
> > > I think a revert first no? This seems pretty huge for something that =
isn't key
> > > to the kernel, then a new attempt can be tried with this issue addres=
sed
> > > perhaps?
> >
> > A quick search yields: "The
> > pts.svt-av1.Preset13.Bosphorus4K.frames_per_second is a benchmarking
> > metric from the Phoronix Test Suite that measures how many frames per
> > second a CPU can encode using the open-source SVT-AV1 video encoder."
> >
> > If this is a video encoding benchmark I would expect it to explicitly
> > prefetch the data from the disk before measuring the encoding speed.
> > If limiting readahead caused this regression, I suspect the benchmark
> > doesn't explicitly prefetch the data...
>
> Well, commonly video data doesn't actually fit in memory :)
>
> A quick look at the code (I think it's https://gitlab.com/AOMediaCodec/SV=
T-AV1/-/blob/master/Source/App/app_process_cmd.c#L821)
> suggests it is progressively mapping the file data for a given frame
> (or frames?). So the old behavior would result in page faults for a given
> frame starting readahead for the next few frames. This looks reasonable.

Yeah, looks like it's mapping one frame at a time and even that is
done with 3 mmap calls - it maps luma_read_size and then 2
chroma_read_size chunks which are consequitive and could have been
mapped with one syscall. Seems very inefficient but I guess it's
legit.

>
> FWIW I suspected this was a really weird case regarding mprotect or
> something, and I'm happy it isn't; but at least I had a suggestion for th=
at -
> for this, maybe dropping the change (for now?) is the best course of acti=
on.
>
> --
> Pedro
