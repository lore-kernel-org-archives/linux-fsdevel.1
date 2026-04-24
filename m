Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03173DBD5A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041339; cv=pass; b=N07Asvus/T/ysjEODR7QNAcsppKxAiGx8c2R01+kHWdI2fh35VzBfVr15eciOHK/27yjB7cBT/khFfeo4ED8FM6XGUChkWAgiRabjm6gWlXDU4HLcoUpcb84v0Q8wzCiJfD+lJheFpA/FPv4SMcMp8DKGcNnKZW9Ib/rsWoOHh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041339; c=relaxed/simple;
	bh=p9jt1gHiba+dFBOeRmZKFoj/PrXR4D3UohMC2L6rPSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzQoI9fZASr9IZNuLYXlL60HJj8D4oKnSHwQxXImn1dwNGwvjABpAYPy5+I6DGE+QWpr28T4oNXLQzG2Uofuokr1i2uP6Cjyfokj9iIi86iQBoL0Mffjxol3anzrrvNJ78DMvq27ivYQ5UNQshAIrF0unztONCbGtq/3WaS7/IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG47VSy+; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG47VSy+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so1401123666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 07:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777041336; cv=none;
        d=google.com; s=arc-20240605;
        b=ZqgFTKohwM7S85zVK3NewHmQ2ufLJrWVsj7whWRk8/gCtgjvMiVfTaj1ZsuNvoGEDH
         KMUC1g2uMqj1LkdncU08TOol4/6wi9Dbv8IwJHFrMwxtpIKMbhwvFIX8cXhxUFYfvFfB
         ve/VqTi5zmiPKdzGEK5cCJ7oRK0ZRNIxkjb59B1+6oXslXbWfxT0mN3pMtMu8gORbXAY
         ep9cNSuYIqIsguv7sKFP/ru6nMbGWjF65vVZs2MO5D++yqHXDaG5ZBArrRid3sC/E7u6
         d5xwIXBcbXs4dl0/xeDsl0aBnoyBMp8+atAuNvREISdsa+Ui2P/F7qqSOCM1LiY+D2CA
         e95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wytk7xcJQB1xNQvFPDmiI04wJ1luZnUZ5xfDJ7i2YWg=;
        fh=6eJUpvYr8a6f6E4KRfHoKo8iK1H9OUUR4eTfi99gXlg=;
        b=d/2FZ2iqmaXT18Dj0a4Qjj43o4KXkLlfkVbmHi255k/arQkuby9apGW+7iyvGEh835
         KXGUMgDkM2kvVxoU6MIA1/2xiwAoQN0a12Cauyo1MwUaP9yhng50uUhyGjZsWrMXp/OS
         kO4PJwTFTR7carFr1WgUIVb2vbRmiAruXCHOPfz3hSSy7tR6VIr+rSf9MiTJZqC9KIfl
         /VygqEJC1ErF93ZaY695nOKboQywUSIGq/RfKvoCDxmNh+Pax3NddfhsP+rW8GpGgSJ6
         BbBraibSRkLWueayrF8WZV1ixuIcPmGEWIGDxf3P0YcERaFAELjKTgFpFa79E5Z1YL6w
         qKiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777041336; x=1777646136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wytk7xcJQB1xNQvFPDmiI04wJ1luZnUZ5xfDJ7i2YWg=;
        b=CG47VSy+zOLdWI83PngziBgYIMIxdBsxYBEhf9wVb6IlTbadR3sgMoJLLOAP0P+Ekj
         o9xF05II94+16RyKjQJJM19hCib6bmSSmcWPol7uFjuKXRX2zhmqtfQVrJxqoq74Km0f
         apDMbRbr4g7F9xsFG6PUAQkFjjLmD513Z8vSBZrsteix3q9Bgmx4ZNM8/Qfbu/rhGCOm
         ORsqrVeGnRuSLTj1vu0r+bk3/9PGWnr9vJyrgjxem/5u8WDQuqhKATbtmBvpQXwLj30M
         nz8bkepCjFYiPV0qCfCRlGvexr46XSw597ZWK6e6tJ1tF0tibJHIzfH+Nu0mH5qvWtlI
         If1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041336; x=1777646136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wytk7xcJQB1xNQvFPDmiI04wJ1luZnUZ5xfDJ7i2YWg=;
        b=VW6BMcHTX6nSjDu5uRHhsNFuJQ5egSbzSn3KLoToPWFY9KloflhB2XKt+VUQhP4PdT
         45bBqpNzxlY5amHgaRyR7Hdwjoo6lUo7dgPzF2ZdpbDMaiPMQWDjsoHPouAuMWfigULZ
         8KE8rouHH/Sngu9RImgMQD+Lfc7713G9g2bLZaXvw+DGcr7aJWZzDLe9sgO2uw40k9UK
         JdCS8zJyUTtMXRwgYy5g++XZ/KrowPArvs5ytRjtvYFqN9WXBi2bSUXg6FYyHsEUlo31
         QSo+UYmXHVbrXq395wnRN19iAGRbIZobVYcI0tX8t+CYsfvuNmivv/y/rfIG27Zaij8Q
         kmEA==
X-Forwarded-Encrypted: i=1; AFNElJ9fGp9h8f7s+rXTvDKItMmYSE43kOzqrCWFxUTt3s7dFjEwcgcMNL1ttoYlj4+sAIm8VPwCXmkcRhkKRlsi@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIDQUYjZzukgHgkTPSTlFOTLgRJ12Zp6AJ+m2IQk0IMgw5AeH
	eii1z16g+wdqo8G/b7nuUQ4IiMqAH9pBrKLdJcJddSXRA554csi2HdXQJhe1YEkBiIAuBd0r/0M
	zgfaR4drjgMvg5jbeGG9Kh+rmsrk1YHrKA3DQRsA=
X-Gm-Gg: AeBDiev+qBsM2k/9p29Z7PALzJ7JMXnokJXX4rDbWdXHFJtsN8Qsg5G+jCxx2rqHOfC
	P+Mu71OOQumU6QFQCwBR0K5MBdv3PFDJfS2fU3vqNtV4KBjTyd/QwhEe61235BD6YJyQMaSEUBJ
	U4Fx6zaZhiA2tpqXQCm6xSZaF4sxa1pbHyJMBmQSvPhJGfkCSQE6SVQib8f3nw2LWh7BHqLWYml
	2KIyTGTIiucRv9AmlMoUXltIyJc2aAmbivSZ3GNTlfsrfB9vvzjNpUJxyZiqT8oRunl/4yBWyu6
	q+e0TVNXDdJwgf49dQV/I2FqoJKd0UeHoACQwJ0HuV7SP9FKqVhY
X-Received: by 2002:a17:907:d93:b0:bae:58eb:674c with SMTP id
 a640c23a62f3a-bae58eb6a09mr81309766b.24.1777041335826; Fri, 24 Apr 2026
 07:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
 <ad7Tps4tkNbndd9Z@groves.net> <CAJnrk1ZWVsKW2dhAWdBkCQskoTE+hmOhPFDhyz4EtExn=GdXGA@mail.gmail.com>
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F> <CAJnrk1ad6t6CJV+xnXwhoNHrHYA3htuaVdDq47FeT60cPBzj7g@mail.gmail.com>
 <aeHXQ2EW2ivlLb_N@gourry-fedora-PF4VCD3F> <CAOQ4uxhXTTyySG3tXnqNnP0edbbwUxfeeC7=CypDSyw_Mod48A@mail.gmail.com>
 <aetxDlr0e9ILFIcg@infradead.org>
In-Reply-To: <aetxDlr0e9ILFIcg@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Apr 2026 16:35:23 +0200
X-Gm-Features: AQROBzDRfaDvwqj3ChfxGHta3IykNz6mtcAvKLit3KlwoyD0SfB9SEJdl9WFDYQ
Message-ID: <CAOQ4uxi2sb4rCR9_xTD3FFEwiPXxDG-sYzvAWqcjMQi1+Om+gQ@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Christoph Hellwig <hch@infradead.org>
Cc: Gregory Price <gourry@gourry.net>, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:33=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Apr 17, 2026 at 11:06:58AM +0200, Amir Goldstein wrote:
> > If this logic was to be placed in fs/iomap/ as Christoph suggested,
> > I think the rest of the UAPI issues could be sorted out.
>
> For that you don't need it in iomap, it could stay in fuse an be a
> generic striping API.  Although IMHO doing it in iomap would be a
> lot cleaner and more efficient as well.
>
> > In any case, considering the sheer amount of discussion on this thread
> > I have scheduled a cross-track FS+MM+IO for Famfs and DAX iomap.
> >
> > I wasn't going to include Storage people at first, but since Christoph
> > mentioned that stride/offset iomap could be useful for block iomap,
> > I included them as well.
>
> There is no overlap with storage.  Any use of this would have to be
> file system level striping, not stackable block driver level striping.
> And keeping the rooms smaller is a win on it's own - anyone interested
> can join anyway.
>

OK. Changed to FS+MM.

Thanks,
Amir.
