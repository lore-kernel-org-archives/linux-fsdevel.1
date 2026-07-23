Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD13CB911
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791624; cv=pass; b=EKvu9vwEjCGZ/XeLO863Rn9KAU1ImkVpspttMTSFEzfjqCOqs8yASr4J71mR8Cqd9mqrDI9iBNyyuSQHFPcibsMCY7ZLN7ds/kgJ/fJDDG6GhIV7YhrJtL0XvLdvCim+k5kCcH9CHPuW8zbR5TEfYgCwKjsblYwdUsqr53zUy0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791624; c=relaxed/simple;
	bh=b//sUnMrNPrgR6EPqqnROk2FSBW3tccYwHVa9XOhJ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bY7G7Mz8h4gOE3CK548+MrEaTPsX7P64D6tUJduB/grbZabMciXXqrmxTFtUwAcqycNSPK9LasHkut6rhRxqQe9kLkJUwsPKSLpOlTRRbn+TjbNc+lplAlTHWo+n4s7V467b1Kx41fzCxh7/ICgWMG6TAWiuDQnEkbvpmihCPwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=X3o3WsSp; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X3o3WsSp"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7c6ec9dbso28597085a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 00:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784791621; cv=none;
        d=google.com; s=arc-20260327;
        b=TLQiWml1Oi6CUR1FGVUOVLWoxzweOvGhZpxbDRjeR6RcI5dbGqglFXB08o49PqJcai
         PEfsMyfhMRRfJm6pmHlGTJuC9Vh6P53dIwAOJ3ncB3pAcLIZ3oagMmwUrepHaoEyTpcz
         NNEENoVXyD1xcUZP2Gl/6mK58wbZGkvwptqduiSKg6wJcanMr6oP/T0qKONJ66JFIjLq
         xi48PQ+kSyqbVliiAOGYNRRFFe4JefjQzGoFoFHKTkBaLrmQC3Y2l6JatapmiG+zshut
         Rc+P6WZrZfq/Q+6AX2X3fg5PiiBIVf/GLfOHueVtXEOBV5k7aM8gPrkuZ8qrv3TmzZGV
         YQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fxFO3X4XqUIh2d5y311IhLxWE4w0WxZ2aZSjb8KpjAY=;
        fh=OnPs0LFU0vkpQ++566L1bdG8vCLMWy7F4q9SxiXClp8=;
        b=WRro7ifwPGuf0OEvblUj0ukWeKP/kEhekexNOXAJwlWwuKOLH8sXAanhiY9HWx6t8o
         viQle/5srX+IqQNm/Z2x18RV9t+LdVD3ZymGl+RN5QTGw2baPyciDdYv1MtboXpzQvAp
         F3vPfHmovjGnGy+PLVzvI2f3wZG7AFhqjqrrhiPE9JXoUXh0Kz53TPR2gKGYJaFkrs1t
         M1OQ5ZNYSnz9aijf3YKRFLh+N6CL1xQlnJj2VcyRrXagz7+EM7sYjMWMyTEyK7L27dtN
         55CDDAPOub6R9/PxqeeoS/v60MFfOxRo+5wyGM4XWK0r7SbvAbT0bAeFPAgmY2rrRcti
         KM5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784791621; x=1785396421; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxFO3X4XqUIh2d5y311IhLxWE4w0WxZ2aZSjb8KpjAY=;
        b=X3o3WsSpKFcJR3jXdh+qr8BcbBAOwlYAVRlHxhCZ01sHkIfq3AJr0YAc83uNiXkjKY
         zVgpRbm3dvkN3frVlZ4e76+0gnk7puwWRR2EfOGV3t+xTih2wu4V5cNRPxI7N4laKIcp
         KOAVBVldaXCi+DQXNk/98EwciE7qXlj8xHEQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784791621; x=1785396421;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fxFO3X4XqUIh2d5y311IhLxWE4w0WxZ2aZSjb8KpjAY=;
        b=aodDHKFXNpuqPnZWGWNZa1+aH64urmCEjSOGCuPa51lOxBindYjT7DaBX+ButO7fOW
         scH2tI3hmKCvt8KibcaPGpDP4rpqRXIY7brdkY+EVpDe6IN0NPJIsvawj7OlRhKNp4nw
         cb/WvPxcl54YSu9iLB4kE4MCjss8gzJumuR0bZVqkRwimKcSaze2qdAnzCHOfdeJsMTe
         utpsEi0hsJp3j9AFoOjK0/6WYX4XaSwhVnDC2XNfYN+xF2SLiV+vAg9AKWMLcCW5ETWR
         yRN8EkfhITOomTH7yc5DZnUboFlRL61J0tTDR+NxrrDAQVpubk7lRNB21z+Nv/XrRDmC
         gg5w==
X-Forwarded-Encrypted: i=1; AHgh+RraSWnLz5i8Sf9Io0bGtXUWzzVBR/pGaIAbsHNy/G5qweRSqfmQrf7JqPJSlgfPT40HnOwAHw37WNWjsyUV@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpFNap4ApxBlpL1fyDmhOk+bIO4H9RKpZehy0YYDNttqR+mY1
	k15f6NVMLv41c5CVoaU5F/6m3kKCTHmMTmhUcFtcRa3APws5svPeyYxwySi0PfPqiCxv3ieeXKo
	1GeXXKuonIKvl/ZsS/fhPUiFzEX9k2DzYD4PJ2iNUZQ==
X-Gm-Gg: AR+sD12iu4oZlB1bplJ1uJqtEKSXShVJnJ4TK2hqFjop5tE/Dus6ali1TiF1PsLc4rt
	b7BpeggS/JOP6MHgUJkbGCRxXO/9xUaKpN+61RHM79fn+5G7ZMthTkUOQt+IJ/TvDmPVG4mRVNm
	dOuPE6Xzb1m8IgughLT3so0ImlpaW5/HDiuC2I8WzPR2niXAq0yRGoJ+9jLg04MIqvcbKSMpiVN
	VGuiLTZpDMsIOs48opr75kMGZ20mziV4+wF/29mNsepoAehL2V/rdwZcXhUnzWK8LaCO5TEEzEv
	wiPR+1zDcAVJm4fIqQ==
X-Received: by 2002:a05:620a:2548:b0:92e:bc28:5479 with SMTP id
 af79cd13be357-9310384ec50mr192569785a.2.1784791621432; Thu, 23 Jul 2026
 00:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
 <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com> <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jul 2026 09:26:50 +0200
X-Gm-Features: AUfX_mzfzrRwI4hZxEkdZS2OluMEiPX8JQa0b2ZxVMGEYubjhyQzQWfbCHdsQ4U
Message-ID: <CAJfpegtnja6tkOnNPD2WZxu14Dd+UM9AvynsVB_E268iSXLbkQ@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <john@jagalactic.com>, 
	John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 at 16:43, Joanne Koong <joannelkoong@gmail.com> wrote:

> I had the same impression as Amir. The FUSE_DEV_IOC_STRIPE_OPEN patch
> [1] right now is only for the interleaved case to handle striping, but
> imo it seems a lot cleaner to make FUSE_DEV_IOC_STRIPE_OPEN a generic
> interface for handling any backing layout that corresponds to a
> backing id, and having the simple extent case go through this same
> infrastructure / path. Especially since John's future patches for
> adding the interleaving will go through the ioctl, it seems nicer
> server-side as well for famfs to have one consolidated path instead of
> needing two totally different ones.

That's a valid point, but I still feel that those things are different.

Striping:
  - always static
  - size limited by the number of devices

Extent map:
  - may be static (famfs) or dynamic (general block fs)
  - size is unlimited

Doing extent maps with an ioctl makes it clunky in the dynamic/unlimited case.

> If not the ioctl, what did you have in mind for a generic interface? I
> think anything else would have to keep GET_FMAP, but maybe I'm wrong
> here.

Good question.  A NOTIFY_EXTENT_MAP (similar to Darrick's
FUSE_NOTIFY_IOMAP_UPSERT, but multiple extents) would work, I think.

Maybe the striping setup can also be done with a notification.  The
original reason for doing  FUSE_DEV_IOC_BACKING_OPEN() out of band was
to prevent security issues with writing an fd with plain write()
syscalls.  This issue does not affect io-uring, which does not use
write and so the ioctl can be completely eliminated.  But that's
another story..

Thanks,
Miklos
