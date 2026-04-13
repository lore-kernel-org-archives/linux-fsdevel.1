Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEE1A38F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107917; cv=none; b=HCdQXRJ9ZToMGCLea3SXjkHBzbRrLObdNbFEAqUOm3vbGOrtZxuw8KaMRwg/4sgoVhvzL8Hk3JqhfPzsBgWXPAfGCXveMeyvxlkoYEIu6t4vSRlJlPmySV5Z+rHbVY2vzIHIzgiM0Or56cPcrU45AXUKc9qxWrin2QTDqTxuwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107917; c=relaxed/simple;
	bh=vX61R8K0dPym9mcNgwn6NpBWQIS6yTLBU+PkAWTjx+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQy2cgLTxoZEQdbb4igYasS8BPpx7tP7wSGPDnF25tOOb79zObWZyj59qc3UlWQVMLrNyVJ0g2yGALPnctnhhfwHodUNmeDUkNyC6yxd+fccSX2ZihvD3HXArOXoOoUkrSyYIfny83Qe1HBhkWT1hH0ykKKFyw2JwATFoXxF0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=absArLp8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="absArLp8"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so721818766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776107913; x=1776712713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KJtQCb+s03+g96ut+/pY+jwhkU8eSaQqQD3FkNqMZc=;
        b=absArLp8g16GtMPYvEPH/S3ExoeuK6AHgN91XcD7YTFotoOK5QIz/GvFTtyOvKqGUS
         mZ2Xo60qNjQ3mCn4omr2SCfcl0M5YODD2P8mXTk+Y6uNGTkL1nFPuJ3tcLFahEn6WpkQ
         IfXFdJZBUPEtFD+xNYk2zJ17fbOOjHPNPddqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107913; x=1776712713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KJtQCb+s03+g96ut+/pY+jwhkU8eSaQqQD3FkNqMZc=;
        b=CPVYl0nTUE4hIGqVbcNdEPhVUkqRfKq80TteIF1EhUTJZOdWOlK8lqTpojf96u/cPu
         cUvUrEOnReYSCjYGhKLKCRpHypfojioTP8Ji4WzaVU61BpkuUxhXQSQArYGqhUtZn7ZE
         BBs8AWFqqcwQq/EHYeWJ+66Mgy0Vd2ppvNaVTIEBRKqHErUypIz98+jwx1TrDNaLBXir
         nb1tuTIp1xl/6CBSAMCZkDbGJhrhqJ2dyJNLlLkj8EUkT1Dfk232mkDdUH1JMl2v6ysB
         wv8IiwbjvEmEpS5WsSXDrxCIkO1kMLqcN3XB2Sjcb4Sz7X5Aq5FME55nWWhG1f+GTD7m
         6bqQ==
X-Gm-Message-State: AOJu0YzMMINmW8HcaUIbEjxOsgWpc8pioKBNgFJniOL7/ojV8Rxmsbjz
	wJkeqN3RWP9BXXOlv4VqHKbJNixC3uUFuPvAR//jngPv+PNBSep78GxeYuvfxxY87aUED1L/fmt
	2uiTG9ko=
X-Gm-Gg: AeBDiet7XY6R4OMx5sPoj6oH5RZshF4rjBx4tf6nsWfGB0/N2GNJqIXoNnUB8LKnqaA
	K4TQUpOOq+VAuXDrKJoWIUiq+uGorz7r7FrLFg2YJG9N9ULYOfYPNiVyzZ0ypV7nFqEyQvwXpTm
	CvPt2TeSlUjgiaLP4XvnQZmbc1sHhVDkDTGdecz9/gzDVX+wW6lafbGJxhdcG0dZYdq5QaZsiG+
	eo62LosJYHMgbhy/yWu6azarr3zwnuqGeDxXeKp1LnVu3VAEdpIYgJe+vKrfsac3v/nxLkiRbia
	LGOwdomAOegWacKNpZD0nuqwF04501d1sQCIUkacMfQZfACTkrA6XwccARZ2krqJdnjruLmajo8
	GOs4uiVFnplAcKW2KbVnTwVh5fvEaitEpgD+UkVZhgN6ay6kLmqXeJAKA27lNDfOUBlOIBNhkis
	02AszD3ylCCHIoBaBcZDJYqE73ri5vD/CFw3jT2xioAqUqGHGk7QzvV1uUAvqySzNbbQuPblu6r
	TQw6etzWfI=
X-Received: by 2002:a17:907:7fa2:b0:b99:7697:76e5 with SMTP id a640c23a62f3a-b9d72137273mr822798466b.0.1776107913334;
        Mon, 13 Apr 2026 12:18:33 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8492sm339912166b.47.2026.04.13.12.18.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:18:32 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67011a751d2so5313919a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:18:32 -0700 (PDT)
X-Received: by 2002:a05:6402:4349:b0:671:c135:a78b with SMTP id
 4fb4d7f45d1cf-671c135a98dmr1140287a12.17.1776107912408; Mon, 13 Apr 2026
 12:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-vfs-v71-b055f260060c@brauner> <20260410-vfs-fs_struct-v71-cf1d44311509@brauner>
In-Reply-To: <20260410-vfs-fs_struct-v71-cf1d44311509@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Apr 2026 12:18:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW53j3vmc1Y58-E_8jUBJtjgAVxDRt+r-w3WPQN+Zm5w@mail.gmail.com>
X-Gm-Features: AQROBzD3N4rFqikK4V_wkHb8Xol7EwGoBYxTmDJbKtIn0FiwPdGSyfLAcjvy6NU
Message-ID: <CAHk-=wiW53j3vmc1Y58-E_8jUBJtjgAVxDRt+r-w3WPQN+Zm5w@mail.gmail.com>
Subject: Re: [GIT PULL 05/12 for v7.1] vfs fs_struct
To: Christian Brauner <brauner@kernel.org>, Waiman Long <longman@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 08:18, Christian Brauner <brauner@kernel.org> wrote:
>
> Avoid excessive dput/dget in audit_context setup and reset paths

I really don't like this one, and I'm going to at least delay pulling it.

Because this really feels wrong to me. It feels like a hack. Just
looking at some of the paths that get modified, we have that
copy_fs_struct, which does

        path_get(&fs->root);

to increment the root, and then the very next line ends up being

        get_fs_pwd_pool_locked(old, &fs->pwd);

that copies the pwd very differently.

And the only reason 'pwd' is different is because the audit code
treats pwd and root differently.

And that, in turn, is because the audit code is just historical and
broken, and can't deal with chroot environments.

The pwd and root paths are two sides of the same coin, and any code
that treats them this differently is *wrong*.

So this basically takes a audit mistake, and makes that mistake
visible to non-audit users.

I absolutely hate it.

I'm going to think about this more, and maybe I'll end up saying "it's
still ugly, but whatever, I'll pull it anyway".

But right now I'm going "there HAS to be a better way".

And maybe you can convince me this hackery is the right thing, but it
really is rubbing me the wrong way entirely.

The hackery is evident everywhere. Like that

        /* Release the extra pwd references of new_fs, if present. */
        while (new_fs && new_fs->pwd_refs) {
                path_put(&new_fs->pwd);
                new_fs->pwd_refs--;
        }

because it's obviously too painful to switch everything over to having
a "decrement by more than one", and this codepath is simply not
*worth* the pain, because it's just for a stupid audit special case
that is largely historical.

So I see why this all is done, but at the same time it realy strikes
me as being very very ugly.

No, I don't have a solution.

My gut feel is that

 (a) audit is wrong to begin with to think that only 'pwd' is special
and that root is always printed as NULL

 (b) audit should not be taking a ref 'struct path' in the first
place, but to 'struct fs_struct'.

Again, treating 'pwd' differently from root is a fundamental mistake.
Always was. The only difference between the two is whether you had '/'
at the beginning of a path or not (and the trivial 'different system
calls to set them').

But as long as it was a mistake just inside the audit path, who cares?

But with this pull it's just broken garbage escaping outside those confines.

So for example, I'd be a *lot* happier with some kind of "borrow the
whole 'struct fs_struct'" model, where audit gets a new "borrow
reference" to the whole struct, and then the places that actually
change 'struct fs_struct' would create a copy of it and replace any
pending audit users with that copy.

There are exactly three such places that change it, all right next to
each other: set_fs_root(), set_fs_pwd() and chroot_fs_refs().

And we already have the lock that protects all this (fs->seq), and we
could add a new 'struct audit_borrow_struct" that audit uses, which
has a pointer to the 'struct fs_struct',

And then audit would borrow the whole thing, we'd keep a list of
current borrowers and unborrow it at the end, and absolutely *NOTHING*
would change in the core path handling.

The couple of places that change 'struct fs_struct' could then just
look at the list of borrowers synchronize them (create a new fake
'struct fs_struct' just for them, and maybe increment refs at *that*
point).

And it would actually *improve* on the audit code, because now audit
would at least *have* the 'root' path too, even though it obviously
doesn't use it and always thinks root is a global root thing.

And no, nobody would ever bother to fix audit, but at least
_conceptually_ it would set the infrastructure for the audit paths
getting this right.

Yes, yes, the above is very very handwavy and I didn't write the code,
and possibly the rantings of an insane person.

I didn't think a *lot* about this. I just looked at this patch series
and threw up in my mouth a little, and tried to think of "maybe we
could do it differently" and the above is a rough draft of something
that might work.

Please? Humor me and think about it, at least.

                  Linus
