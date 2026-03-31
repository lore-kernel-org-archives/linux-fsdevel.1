Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3D3AEF33
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939479; cv=none; b=dE1uMM7zvtmHPFXwI7HDL3smhcPPw4UgTlTQWnLCji0Kvi9cp3zKqZxhp3Wyhw7V4oETv9pQnCh1qZ1VUNIpWXvPUTq3W6jDRCaf19pQ7nyvqxmNRIOsajiHv0Q6gHHyhN1FiBsqva8KLPMQklt2OJ6fi3hN6ZM9Fh1OX0IJ4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939479; c=relaxed/simple;
	bh=zBBx1RuANqq0oV0jiwUB3uvadpOdqtS/qQo0i+7QFmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAUfnfP5oEQQS/jaFmYVa9pSPIfp06fO7QOHU9cqJhYLOZcHbxBjtlskZXdXZVZD7JvttQ1ndmU0kd4SASwBTeFQyPzIMzrdJEfbzw/TW4gLcInYALWoB94hCsooCmJlltC8UeZOvqkF3FQ/RY0PhV7Bh848jFLwMCqpITzWP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c131yqMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c131yqMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18750C2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774939479;
	bh=zBBx1RuANqq0oV0jiwUB3uvadpOdqtS/qQo0i+7QFmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c131yqMx0Ksrk1Gj2kmF4BmlTYeQXKrxlG9anMASw8wnLuPTLfPtuF9NXjfpW1/st
	 mQ08VpdoASuYkgWnsIleoZu3U0dJ1+z+aRkfQmbrQWNdMcqamjCxkIJtnCiun6B1+h
	 pnvfae+GMzQGAelL2i1C8/oG45Nn7EtutHVOuXVgoH7Kmcum4pYNkX89pqYEYUYzxC
	 LH8Hm59oavMU5WwbeoNreBzUSEgkMAU7+L89RB/n8tPmjoo7yHTujiY2Ry5Dzg3Muz
	 rvoIZwhjI7ZjD1Msb09AHcmERuffhn7JEzmBSYtkxEtkUxhSgQy4qOySzFUxxCz2oO
	 xozbB7dS8+J6g==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so6334525a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 23:44:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSBVuBbA5WOm/aPqSmn8e1bwsrM4c/cwvd0IDsRIWmi9eoGAaskiGK+PRAXoB8eIDKCAyJyjCdR9WQhrRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9u88xE9ZLQksAsGieoeMmMQOWTHXWR8idccKEZn7vPZ/mfBM
	Qlif5LZt3vSXWZ71VXD4KzFbm3NSwlqDLN3wlx/vQa28jGVdxExhpmEuGfssCOv3+6bqj0jygZg
	QjHpKOL/QnqQ6lr1NhdqPS5q8VBGDUuM=
X-Received: by 2002:a05:6402:50d1:b0:66b:d453:8a98 with SMTP id
 4fb4d7f45d1cf-66bd4538d52mr4127921a12.12.1774939477587; Mon, 30 Mar 2026
 23:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-2-linkinjeon@kernel.org>
 <20260330063059.GA5897@lst.de> <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
 <20260331054859.GB31506@lst.de>
In-Reply-To: <20260331054859.GB31506@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 15:44:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-vKjh8yr24nBAg0GkPGzXUqAEnrpSfR-SBmhR9Zptb5Q@mail.gmail.com>
X-Gm-Features: AQROBzClT_iictzryZHGB8tQvj16b4Gdz5CxI5kEW8b2kT-K9cJMImBiZGkGILI
Message-ID: <CAKYAXd-vKjh8yr24nBAg0GkPGzXUqAEnrpSfR-SBmhR9Zptb5Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 2:49=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Mar 31, 2026 at 02:26:55PM +0900, Namjae Jeon wrote:
> > > Can you explain the logic here?  Shouldn't the iomap buffered I/O
> > > code do all the needed zeroing for you based on the map type?  If not
> > > how could we enhance the core iomap code so that we don't need this
> > > in the file system, which feels like a bit of break of abstraction
> > > barriers?
> > The reason we have exfat_iomap_put_folio() is because of exFAT's
> > VDL(->valid_size). When we map a range beyond ->valid_size, if we set
> > the map type to IOMAP_UNWRITTEN, iomap_zero_range() does not perform
> > zeroing.
> > However, if we set it to IOMAP_MAPPED, then iomap_zero_range() treats
> > the area beyond ->valid_size as valid data and could expose
> > uninitialized garbage data from disk. So it explicitly zero out the
> > portion beyond ->valid_size in exfat_iomap_put_folio().
> > I agree that it would be better if core iomap could handle this case by=
 itself.
> > I'll check whether we can improve the core iomap layer to avoid
> > filesystem-specific put_folio handling for ->valid_size.
>
> I suspect just adding a new IOMAP_ type for this should be fine, as
> the above description sounds coherent enough to add it to documentation.
> I just can't really think of a good name.
Let me check it:)
Thanks for the feedback.
