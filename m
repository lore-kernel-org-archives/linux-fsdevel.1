Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300C4A68B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048298; cv=none; b=D9HoyweNfO9vgg24ff0aDtYIy4r3vqguD39U3EsDPHOCn0iaA2WJntduW7+KKicvoBx4s3PrIQaJKkyU18YkpcN44GRwbCm0Gs30kwTl4mbV7FqoiCh8iX7JnteeXHZpUkqwei0PxQrkIGLkgwWq5AQ3Z4q+q3+yR5CxnHJLZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048298; c=relaxed/simple;
	bh=nqyge/YJtPDcwuFY0ai30R3h+9VL2QlZfBO9AXZ0gkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcpNBnu1e+16B6uevgoLT30ZwjZx/mBZ5o/y+cONwP52ogWk9mn3EcRznRvL9gu8qfJtuwH85DJhAYw6mJknmWUcwWU3AGP/EDR2SIjuPcIU+oz4dLhjFGo3+kYvAY10nDgiBUlq+yw21L89CsIwnTF1UierE5Beyp98FDudaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OrMdfgAV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqNRl2GP; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OrMdfgAV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqNRl2GP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id C54291300CEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 03:11:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 03:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792048287;
	 x=1792055487; bh=kWpbabSXhdWbiJYtYKSzWotKYpXwMvC+M6lHjBExri8=; b=
	OrMdfgAVZ5soCn7uKRR6Md9IoysXyJN2j0ey7UxnrvFZmG6Y9saj4qc71jAqWiS0
	F5MSi62rMdlUgWzISuU/0VYPu7WkUs3oP35iEd+H1M2xGDBLLcZm1DwXbGNn+kiG
	lJ2pVF4rvsHTAGBe/DIfQzqagYaLx8+nqotD4Q+nNKfPpPPdnzroDA03gPveFnIf
	xUoKBbKBoUZAxeQaykxLTysCW6vz058YVYMxSJ6n9jdw2+8N3CWmslG+ssE2SdzV
	SYdJgegrvqegPOs8gCZQ84rvJaZtsA7fCxZkIgNQ2jYKfd5YCBm2q8vwGGwUQAOC
	kxBTrIhSAwcieIIPTULAfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792048287; x=
	1792055487; bh=kWpbabSXhdWbiJYtYKSzWotKYpXwMvC+M6lHjBExri8=; b=L
	qNRl2GPZSqFSVjqs4IgS+xqrD2okGxqvXa7SmYu0hlcCj4Q42/1nPDNXZzgYueKn
	sDCkMlPfzwkWsRTyOSj/9ZgTolv+Ig1uc4CEEKJURjLagp6f4jbLsZxlYSE5f4/r
	hCGs/9m9fIHJelXUadPBKvNoQMNa2R8oV/nnUey48kxw1lGzvp4YVPyUVIorrKZj
	Qy92/MioV+3y+Xsg01k8bmPDZ3Wmgyk2XcACPtk1q9mAS12UAXAGzRFaQLMYQJ92
	WfnqW8uI6RGqYa2yxwhAzRnQhxJjH6WvMWRu4hMo26xBpQmANU23c1osz+vRDqSi
	7ft5nhxHenhEC9/OMBbBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792048287; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:dj/7JZo2bwHQ825WMaV9o/RmSUQl1B3lpz4+/UzHJIKDOSX
	MWkYCkw+jXGyMy7EYr17D0vH24gyM30Xd/eQkZm2JS2hlGrhDY+lX721T+cU4g9a
	BF1tNsTFHFBY1YlBBh1eGPyXA1CHKc1GOsp6oYUK4UTjQKifNn6BHMygqh7AbCe/
	jUX4+ePb2rSUA0OUQU95IFNc0QO8Cq/Q8nlI7/Q/v5tQJiEianD+3YJC+MBey0Df
	W4BZCvSBzj4843wx3RBYShNwCBCTw2HO6dhkKlHtvDK8/S1tfg0aHW1ZnhX1+Jdk
	2BG68HJ+Ix2Ic2A6JiBvEe87NAdPvT3WfvFAaQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5v1S2BselopHJKpcijMJ+QH2LXd5r+IK+uUBIBqg/Ns=:nqyge/YJtPDcwuFY0ai30R3h+9VL2QlZfBO9AXZ0gkE=;
X-ME-Sender: <xms:nnzQag9-oucjCZwTyfr9ueXdEHb0laRMDkE1LtrPxhODERMj7bUyRQ>
    <xme:nnzQapcvuBZs3UcLvUQ8uZ64aFxzkU5NjvSaUDeqC-JlCoXpOU-qf_LTuc0u_xvPI
    -uFyuhFhdj1-pppOFIQ3JQS17oL4Xpei8D04DD5eXJ5NU4zhPE>
X-ME-Received: <xmr:nnzQau4cJya2jX1hjxPaNccn_xGJrn2zbRDHbSvrWBt2FidsROOQsaQJN9X_U7QCjfO64JMhHEBaYUzWZIpZkSejWzN5bkp49mlsDrMbtcM>
X-ME-Proxy-Cause: dmFkZTEHCNm8rEckpzA971pz/REHTOd4bY4N7yQHIPOUVfZ8kXfNbonIoHjVjlkxfaWEGv
    NDSFjZJqgp8garaUvb4+kfP3XH+/K2RmL+PTH8QmtLsHZDZ+SVruE4mPnso0GtKO62rQj/
    w6QlB7pkaIJun2T766i0DlEAMQivbrHGILNIz01wiEzYj5YwQh2ytk7bOACAJCDoHkjKCF
    3+sGPhpav7olGxvjraWofyYsQe2HEZBNW8L21uhFJEUZpdt13hRiEuFUtDo6L9a0xGA1zs
    FIc7EjOueq/f21/FamUys9eDgaPMuxjUiUuxPx+4p5YXVhejmzj0Bo8eGVZsbvxoOWozbz
    jUPCCFPNVm0Kqd3Km7xHlFGgkrkgn6wGGABGBk/MxmmtfNoa6nM2BXr67jwmtlF6ihpJix
    rZ1z2b8yvwdcYEutsM2NPI+ZUiYt4id9LydD2KOW0vdtZbQT6qTaxrcOAKX2I90Mn5hhsU
    XTTx1MYBs/BMwzmuBvTtV/SKB7RcZ0JWR+IK0IREUfIXZqVWcra4D91PI1bzPkQy4zUGmY
    kopd+clgzcsk30ELasuLG90P/s4V0alrpEvEIQfzDTMNmNxBbwL780cwYTIBDP1cXnlbjT
    fAKBPskqApyrb+FDEsBGtMDAbmjQzxaMpaFND8lSh4qCl3gND1rhPKqoKiNg
X-ME-Proxy: <xmx:nnzQaoW7q7cuUVUA2PY8ZzU6x-iz6Z2YTa705VYYlTpZ6wHcIcgDDw>
    <xmx:nnzQakWYBo7C9zYNdv93ZghEw2wbqAcC0WzWP1TpgGQoWJjY9tvKMg>
    <xmx:nnzQahZDTPIKPAGdEUWiS02byBaX0xVkrk8OMqWRr_wn8SAJz4_iMg>
    <xmx:nnzQavUO25yLki4FYEQcU5WuDOuEC7oitvDLdlyI92IrDzKfQNQWqQ>
    <xmx:n3zQahfhaDP2PswuAmOPWqGz9UJehNplalfZwK08jaF9w0JyqKywmX3l>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 03:11:25 -0400 (EDT)
Date: Thu, 15 Oct 2026 09:11:30 +0200
From: Greg KH <greg@kroah.com>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct
 seq_operations
Message-ID: <2026101532-fantastic-deafness-e04c@gregkh>
References: <20261014225811.i.852-kees@kernel.org>
 <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh>
 <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org>

On Wed, Oct 14, 2026 at 10:57:57PM -0700, Kees Cook wrote:
> 
> 
> On October 14, 2026 10:46:02 PM PDT, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >On Thu, Oct 15, 2026 at 7:21 AM Greg KH <greg@kroah.com> wrote:
> >>
> >> Anyway, I don't know.  I like this feature, and maybe it's going to be
> >> used so infrequently it's not a big deal, but feels clunky.
> >
> >Perhaps we could call it something shorter, like `__explicit_init` or
> >similar -- I don't see that substring (even without the double
> >underscores) used anywhere.

__must_init might be smaller?

Naming is hard :)

> That's nice, yeah. And it's not the first time we've changed the "spelling" of an attribute.
> 
> Does anyone object to that? I can replace it with that in my tree...

No objection from me to make it shorter, and yes, we can always change
it going forward if someone comes up with a better term.

thanks,

greg k-h
