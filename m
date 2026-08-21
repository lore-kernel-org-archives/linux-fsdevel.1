Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2243B8BCB
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341181; cv=pass; b=UWx9uwhUZVC5dAaBuR4R6TvNhbdGioS25HFlyN51r7Nitw4EmeGKhFZlLPuTFfm+E8hZyciCxgyBdv43VF72FomdF2CKy4hZXu9g+oR42dS46CxUNe4eY5GZIM9OC4jaqZhDubzeQBTlWir2b6YZYCzz0oPxgeXM3pj+ccrQ2pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341181; c=relaxed/simple;
	bh=2QaAsriM6IS3lTgDPUOF48nwqc8aTC29sa5P2y66CZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvFO/YyjcvD1ReQcRJqU+eP5mwBZ14D1nt+GhIOTVYLUoLXrzhKxSS0bTr3NfYOT+MSMwRLHcvgxdmF9qo/SsOtIgVWJicfIk/bF57iOi0hnuPB1H/sJEzRRuYVpveh/sUEKXc0WV9YTAneo8Ah3opuWQpzc1VdGZfjFzdblkvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ntRi3l6f; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ntRi3l6f"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efcef23d21so9407656d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 12:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341178; cv=none;
        d=google.com; s=arc-20260327;
        b=Kjd1l/1s/hC6i0fWoHldH5Ji9/lj6W5xc4q2IIdvhso2UlII7C1cXTUAext5rsep35
         kaVfDeEq3qvjh9JI8To/T8PG0OoyE0Ni7QTjvZmS+kGKo1PJ6gvtiMS5yn5ptRcbitGh
         oVZd6lRG+iZvgiD7U97avnGPwHnU0KKNfPovE/NCiIPXyfb6G6APF18Ea+PmdpoFmHaU
         l/ff6fcyVqmmeY9T620b+tnUJe8R09bTcgNXifDic/zEqVOKKHJij7sIraFvE/yxP+/7
         6e3f1An3WxC8KBlgAEl5qeJrj8t9Xc+hO9EjgahiHTgxvoKhCfQX+X9fApqJSimoDt/J
         Tpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KUV4QsUdOhj/C4gedxjcRezZM90WK5l233fM+QINPEo=;
        fh=QZW+7uBKAV1vveWiLhNKSacR9z6Z3AfREss2Z04dpho=;
        b=ps9RebKTcMrorpPxhqiNmv77VQO6+4IlVnzD5okkQZ75xTOC6RPdS8fPnLQWQDEpNX
         OZ03EyblUFpXprEuHndtIgvowpQKx+MD0BoTsXiYP06Hr2fy2qbQ1KfqC7dg+eCaoeor
         0AbwQ4BPklF5fX4SF9R0i9ZpCRicut7TfJfFz3wYmDg1QjpGd3gXNmIUtn7LZ9PZTn4o
         qG/raclk7ykf/TubkaBCuSnhfkGL9Q3y1MvRYmbsGWbsztFpKjAEtMLFPhwUC8zpvLgc
         ObVNpaZN7gWmi0cf9gkKAtkov63MlNXlVSAIG8CpU2Sn/Ndg12Fn+OuvogXWk2s1qQK8
         nVMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787341178; x=1787945978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUV4QsUdOhj/C4gedxjcRezZM90WK5l233fM+QINPEo=;
        b=ntRi3l6fuSV9/6tG2fuYlr7KOGFjHLWC/IgW2qf4q3GpWubqv3EwQ7RyHdfc8ip+bC
         BDtWmCiJmttrako1jPZQNWy5Jaqm4OO197ZG2Rd93WJZYtJjQ7TA9wN/jYOZEeWm9gF0
         Ic5xTwX5EPosMMv4rEDJxzTHyYNoRBavvuNXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341178; x=1787945978;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUV4QsUdOhj/C4gedxjcRezZM90WK5l233fM+QINPEo=;
        b=f9C3L7Y6E7abQ2sKa9l6dO+2xvCPLTr8jcvco9s6CIDw4MOhBYl8wFAs1m/1Fl43Dp
         F0jno706VXvrpWtut2ZHM64wB8AVid3pno2ikBJep3BJcgUQ5NXFZuAuS4ZJNZfDYUOt
         5kq9K+Tka5SSLHIbiAqQjO5gB9Cum5bVaHy1n9DJuCRTO4JTdr227HpEDexx8iDc0AsT
         ekK8wesPBjjbmjkfm3frhcuqYouIeA+5YHRMeAocHzIhne/eYHCYAkk0jtcZFeyh+ZFt
         IWbDxEk/8ymxoKKbgTRjM9tiXdViOgYLV3HyfoOMzXn7B8qry0jBULVukN2sZelEjc5C
         mlWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqexFQSFxFEWIt8gMNocchfDiVcZqta3+7+zywlWsntJ8wXsSvjxNv0+d3Tm8we2yWYm1zUT2Av54TKpY7W@vger.kernel.org
X-Gm-Message-State: AFuF++n2Wf7dh8AcU/4YQ7WAB77i8dnT4A33sBoP6OCoqIZGmoQa9FUQ
	sRbakCQx6Z80yuQ2DdgU6ZL0WKdSRDBxYAhgEnOOKzuiwYL/jDyDjj0snkW3CeR/VrtvIjwhXm/
	oME8M3Jv+C7w1w3e/j6zZzRUAkCLE9FIXysVZs7/t4w==
X-Gm-Gg: AR+sD133aHCeImqvj6NtQoAWs/e/hCrRW2mmLxOuLJDoR4nRYnQzN+hI/KuXyvhRxzG
	LL9fPboUJeadbSoWuaxQL6V97qwFCVEDg01XmeD/shJOBA6koJfKun0U3xc+P9NQLXY/f+8GvmN
	7ytsl5p5BH/7YbL3Zdf3z9TfB67Gknfug+M4LJ4XjO35DGCW9L4dQbNy87MWYt4r+W9uuVMdxq7
	5OiaeaKlWG9PPplpiJVMvFV1t39bP1VfBqcuDGSyXtUCqMPZOIvX1OlrB268UmytihNRAikRRyU
	a/LUgE6r6W64DxA66aUPChNgf1cqW8I8eqBN40kqv5ezxD1bNwekx6T51CNxJ/eKQywI5r6Z7kI
	GFGloYtGdvxmHtXI4j53IITSEhBi8UBHi
X-Received: by 2002:a05:622a:1f8a:b0:51c:1532:ae93 with SMTP id
 d75a77b69052e-52df5a32867mr88198341cf.26.1787341177980; Fri, 21 Aug 2026
 12:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com> <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs> <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
 <20260811-baugebiet-hofiert-fanden-3354f4a5e820@brauner> <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
In-Reply-To: <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Aug 2026 21:39:26 +0200
X-Gm-Features: AcwNN1V5lCcm6_l8LY5VakD6tTocDvE06I1hYgFmfavubxTv285rgBmrPN7M8XY
Message-ID: <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ira Weiny <iweiny@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Haren Myneni <haren@linux.ibm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Gabriel Whigham <gabewhigham@gmail.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 13:40, David Hildenbrand (Arm) <david@kernel.org> wrote:

> (a) Whether a fuse-based approach is feasible.
>
>     Are there any major blockers remaining?

No.

> (b) Whether a fuse-based approach is inefficient.
>
>     Are there scenarios remaining where performance or metadata overhead would
>     be bad without an easy way to improve the situation?

Lookups can be cached, extent mappings can also be cached.   After the
inode is in cache and the mapping is set up zero requests are needed
for open/mmap/read/write/close.

> (c) Whether a fuse-based approach is a bad conceptual fit.
>
>     Will fuse have to carry a lot of famfs special sauce that cannot
>     really be used elsewhere / generalized?

None.

But "can" and "will" are not the same.  The striping code might not be
very useful outside of famfs.

> (d) Whether a fuse-based approach is too invasive.
>
>     Will fuse extensions to support famfs actually make it harder to maintain or
>     slower on some paths?

No.

> (e) Whether a fuse-based approach will make famfs harder to extend.
>
>     Is there known follow-up work that will be hard/impossible to model in fuse?

It would actually make famfs much easier to extend, since the
directory structure, metadata, etc. is now controllable within the
userspace server.

> (f) Whether a fuse-based approach will reduce maintenance effor
>
>     Will maintaining fuse extensions possibly be harder than maintaining
>     standalone famfs?

Testing is a key point.  Famfs needs special hardware or emulation, so
it's not straightforward to test.  This could be solved by adding a
"dummy" mode to famfs server that exercises the same fuse API, but
instead of special hardware would just use plain memory.

> (g) Whether a fuse-based approach would make famfs more complex.
>
>     Will the shift to user space result in a significantly more complicated
>     overall solution that must be maintained?

The server would be somewhat more complex, since it's now implementing
things like pathname lookup, etc.  But the other stuff (managing file
maps) should be very similar.

> (h) Who would help drive the fuse approach?
>
>     Fuse people seem to be willing to help, but I expect that there must be a
>     close cooperation with John to make this fly. I don't expect that John
>     himself can easily (or understandably wants to :) ) do the heavy fuse
>     lifting.

Yes, this is where previous efforts seem to have gone off the rails.
So I agree to take responsibility for implementing the kernel side and
help with the server side on the condition that John has trust in
this.   I'm not promising -7.4, but can at least try.

Without John's trust I'm not taking this on.

> (i) Who would maintain any famfs fuse extensions and own any bugs?
>
>     famfs will possibly depend on fuse extensions that might initially only be
>     used by famfs. Would the fuse maintainers just naturally deal with that?

I can take responsibility for the fuse kernel bits.

> (j) Whether a fuse-based approach has an end in sight.
>
>     famfs goes back .... quite a long time. It would be nice to close that
>     chapter :)
>
>     Is there an end in sight, or could we end up in the same situation in 6m/1y/
>     ...
>
>     IOW, is there a way to agree on an MVP that won't require a lot of further
>     re-planning and changes to a fuse-based design?

I already sent patches to implement the dax dev mapping, and the
striping.  We've discussed adding support for fixed backing ID, which
was something that John asked for.  The only missing piece was adding
a protocol extension to set up  simple extent mappings, which already
existed in the famfs_fuse patch, just needed to be renamed and unused
fields changed to "spare".

We (Amir, Joanne, me) explained to John how this is exactly what's
needed to make famfs work.  We've not seen an acceptance of that yet.

From my PoV this would be extra work, but in the longer term would
expect to be less overall maintenance work and fuse would gain some
useful features in the process.

Thanks,
Miklos
