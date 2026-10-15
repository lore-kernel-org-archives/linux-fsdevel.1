Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84E469820;
	Thu, 15 Oct 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094863; cv=none; b=R34B59RZPK7fqB4encTzyiJj7u8zCYm2RrGmfJNZjpXdxta+dBNwG1C7QNKmkqn2/YqQYIqKD+0H5TyQhaNq9NDFWidgMSBpoQfJzJOHZSxeW9Au0MJQiOrygG0HrqAlispdBFCw1gJqW5KN0/cE2GjaOPdc4xmFRoG4E8YKQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094863; c=relaxed/simple;
	bh=bJwZo2+i7l+nryaZPo+MFuR7VfSge9sdx9fMOwYUWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxj5xcN4/z2sZScQCnY/QMOMB9csAR/PVbOc7/Z9M2HKKGY37JACgLhzXScuPmLk8e96ftGO7gdhYf+dh/AiNpB30LILvP/r/cYP0iHE4jWum2MM4Nmt9FDRqInOldIF1X5sa0Maf7l5tpzV1mNG52dVvPNsCfTPscF1L3SagKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1PCxx85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1PCxx85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0365F1F000C4;
	Thu, 15 Oct 2026 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792094862;
	bh=h8Y7JueFnlr10w30ISUAspNnhsUCZCSYg/z1LwaN3dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N1PCxx85fjDs+moxzVcd/Tg+3+IiXERqzNXbSjpOuVUaqaMBIy1kK5i8nSdu3+wwA
	 N3dhNokXX79ZZhVQcvfCZl3vCtrjYNXjLW5AmvfDCVOENKKz5qTX8CyQk0WbWlNsKu
	 O05iuF0GRHCV6vacqncLGErhyMV2ifQ24z69vV9iSRi5p50X/mUOkuh05T0X4pQ9aS
	 phKKGb5kKh2BcqaGwtcMjrCyEbX30O88Xvtk7Hamae5kR0fZBt5SSq/cq3upSaekdc
	 zm8msIbWvn00FOqDDs9d5sk9kGLBA9DRbDzrEPv9rwMGu5Pduf2vFlwKI81Pxp65j+
	 WRPw6AME3NC0w==
Date: Thu, 15 Oct 2026 13:07:41 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ian Rogers <irogers@google.com>
Cc: Greg KH <greg@kroah.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <202610151304.AA5EC855@keescook>
References: <20261014225811.i.852-kees@kernel.org>
 <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh>
 <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org>
 <2026101532-fantastic-deafness-e04c@gregkh>
 <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com>

On Thu, Oct 15, 2026 at 09:47:34AM +0200, Miguel Ojeda wrote:
> On Thu, Oct 15, 2026 at 9:11 AM Greg KH <greg@kroah.com> wrote:
> >
> > __must_init might be smaller?
> 
> That sounds fine too. I like that it says that something *has* to be
> done (like the original name did). Hmm... On the other hand, I guess
> "must" could sound like one has to initialize the field "somehow",
> i.e. writing:
> 
>   struct S s = {};
> 
> definitely initializes it, yet the compiler would warn. Would
> "explicit" hint a bit more at the fact that one has to actually
> "write" the field, even if it may have been initialized anyway?
> 
> (Of course, if one knows that the attribute only applies to fields,
> then it doesn't make much of a difference)

Hmm, I just noticed Clang isn't diagnosing for file-scoped definitions.
I've opened: https://github.com/llvm/llvm-project/issues/232483

Do we want to wait on this attribute until Clang has full coverage for
all initializer cases, or land the attribute so we can continue to add
coverage for function-level coverage? I'm worried about a compiler bump
(once the bug is fixed) suddenly exposing a bunch of missed
initializers, but then again we also have no users yet...

-Kees

-- 
Kees Cook
