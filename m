Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BB286D70
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334710; cv=none; b=uanehwb1/PaM0aZN6L93NcOiiiq6LlkhKu79cROMYJOqIyWzDVJnFRFl/i32iRR16L0GxYvcKdBkjwJVuwHr6oTYsT6U7olstIo//XP8zoUyZm64tYB2O7/TgrPbmJmEvvESmXEQvN9FWL05mLg14Ew1s85f6/MQSRYkqk0l2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334710; c=relaxed/simple;
	bh=QOF4HTo9NC+sG07UWNWNGhB1bOa8fZKjrboF6NtGYig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjBftv8f8DN6vg/Lx2raaJeNwN7bmpdLcSRU2kHj+v3P1BschUyH8/e37NJLNFq9zd3Pqa2kpV/SGPM98vYP6w5BksJ8rppGL7ad2MmDGZy/K/SAwuuk4v9lCVO3UvKDc+vo9Y0RjJ69+SUy3AHfywyxf0tUjAeOtDFXp0bSrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KUNy3pMx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KUNy3pMx"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa5f11deb2so2952152e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780334707; x=1780939507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8glRJeBkbbvtPfYZZguJlBO/diWKKHW+QvqawLEed2k=;
        b=KUNy3pMx6curGDt40LZZqmKDXZ/xHukYTmdXK8u00ZOza7rKYXaZ+fgw/FiEvdYzZa
         +tLE+yEvKw9HywVgvvYbWGhxR7jm4vqojNkyBpXWKI4J5En9QhcfGm3Etp0wvtX3gSDZ
         5Gg6YhHSZz5dA/JMlAWdcXH3Im/4O8OBP9SfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780334707; x=1780939507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8glRJeBkbbvtPfYZZguJlBO/diWKKHW+QvqawLEed2k=;
        b=juXVkaWtnQtE3Q0vn75z+Lm4GZ2KKjU/QHiM0PKFkYgGT9YOk5j1iepz6WRftlD15n
         /a8AzNmRclhvWQbNEK+KOScpjQGVVhPQ9Tq9t1YUvv7MUsHD7SC2wI0QYxfqtrcv61um
         NCls9K2un3+VyehX3TWgUvZzUdXEdyDXeOSnptJUPAsxNa6c5Tn6uUWVpShYW0Bx0FGt
         pgYdbcWgtGvg47g44Fu/HZmGpp8MWuGxVmP1YRnTE0/IncGgZYJT3tq7G7xYvZQkwvAs
         5BJRYcufI+XAcVUtnx3QjcOYRDc7izGH/tlyDRD9havPhpXbhbE+l1DJDlQTKpa0qr17
         MYDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GRAOyM5DyXIJ2Tuuu2L3s8F8OQwJFgkgtxkl1mKZl92Ay3NV1n4fE7Pcmo+VRyFJPjiVWz7g+iflPagee@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MgY/tgbgDP2orrsACh9MEGimX/L+K57tS325wuwl5iNNTLoL
	XF/CTVMKAVg4FNiUv0ixZsYdntAMm0808gSSeVQ2zGWjMO/GIkhjj9qrYg9aRwqKYUid9h8oAIo
	SsOV93ERvaw==
X-Gm-Gg: Acq92OEwaCLyzPqbX6+qoWpXILfh4GHyraaJoHCUXXiHX2Mhnd8QBkYXRjkYR37qX3W
	ndLawE2vBwGG6YIsUIvnQm9Tz38VPOsBQfusHGyp7Oq6y2uXW/qBLXtDh/L1MxRm36L552f8g/H
	4UGE6bFcP5D+IL51/xeoEGkUsWGVRSHSsMi++uQ0j3wjad2ttdFh3OeU7KFlCUa9Gz6BTw5NTzP
	Z5Zzx+57hivoCmiQj0sbZ+4Pt1AXZq40gVBYrb3vugs8XGALgw8MGBU8eTJnxZTQ9nd+L9qy9lV
	9a/2tIx6UDCov1TCsMkAPdCQ2pbF+Nj3FovkyCT+x6uKW4wLg2rYIT58QoZEKmY3ocZCMYVXtum
	D36hDVnLeVWiVV1+RiB1f2znmE6CMOZhCll7oWQqpHRyjK2YLtfJKzcFl+S0EnD8oP0neApClho
	BZWJNzVSTKbnSuncP5yQi1/Y4k7HqMoqKImkkSHegS8D233Krqrntok+ZYb2CbErVZ6OnE0eK5E
	LbDv5cp4CE=
X-Received: by 2002:a05:6512:a8b:b0:5aa:67a8:7356 with SMTP id 2adb3069b0e04-5aa67a8740fmr2147446e87.37.1780334707094;
        Mon, 01 Jun 2026 10:25:07 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b7965f8sm2209375e87.79.2026.06.01.10.25.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:25:06 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68cf03bfso1976491e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 10:25:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+gawuQYbo0tpjT7K5uevXOWuXvCyQb6dnrle6FSfAqDUqiR/Jl+vXm7/VT7cV9sfUSSyvkuAgBDJXtz+f/@vger.kernel.org
X-Received: by 2002:a17:906:4583:b0:bef:12f:347e with SMTP id
 a640c23a62f3a-bef012f3d6fmr16123966b.24.1780334260114; Mon, 01 Jun 2026
 10:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com> <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
In-Reply-To: <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Jun 2026 10:17:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
X-Gm-Features: AVHnY4KexWf0o1w3H7pefWBidQ5elZSrUhqo_ATAUmEnAO4iwBaX4DnfDRLKUYk
Message-ID: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 09:42, Christian Brauner <brauner@kernel.org> wrote:
>
> Applied to the vfs-7.2.vmsplice branch of the vfs/vfs.git tree.

Btw, if people want to work further on this - assuming we don't get
any huge screams of pain from having effectively gotten rid of
vmsplice() - I don't think it would hurt to look at limiting the
"regular" splice() too.

We already have the code to just turn it into a pure copy on the
"splice to pipe" case: copy_splice_read(). In many ways it would be
*lovely* to just always force that path.

We already do that explicitly for DAX and O_DIRECT, but we made a lot
of special files do it implicitly too, so quite a lot of the splice
reading cases already use that "just read() into a kernel space
buffer" model for splicing.

It would be interesting to hear who would even notice if we just
always used that copy case, and made "f_op->splice_read" never trigger
at all.

And it turns out that the only thing that ever uses
"f_op->splice_write" is splice_to_socket. Which was actually the
problematic buggy case.

Everybody else pretty much seems to just use iter_file_splice_write(),
which does the "emulate it with just a write from kernel buffers".

So *if* we get rid of f_op->splice_read, we do leave the case that
really caused problems, but nobody will ever care. Because once splice
only deals with private buffers that can't be shared with anything
else, a f_op->splice_write() that gets things wrong is pretty much a
non-event.

(We'd have to look at 'tee()' too: I don't think anybody really uses
it, but it does do the "no copy linking" by just incrementing
refcounts on the pipe buffers. So to really protect against
splice_write users messing up, that should do copies too, but as long
as it's all "private ephemeral buffers" that get their refcounts
updated, I don't think anybody *really* cares)

TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
a big simplification.

                Linus
