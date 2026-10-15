Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FFF35AC07;
	Thu, 15 Oct 2026 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043879; cv=none; b=Hx6LcOZqYlVtTa9eoqHSphahNfWtsK/pVmMP6VShgQpB9jxk4vdTcac3vXFwkd2IWpSilpF8rIrpzTQyJjbWEb2rafSOQ6AtC8FldMxA7D+lwgQfxVxgWrTGSI7as6D8lkTNBInuMlc5yA+ZMADKaPnY5IghkAIuRQMnHVqWr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043879; c=relaxed/simple;
	bh=cWjofkCcAlSZ010yGV0lbiXUU1s7UU51hJhMD1Ek+Sg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WW7ENlOgMfoqVoBBoj38XCzLLdq27/JJumA14V2TmxGIgUJxb+NFl+FH34Xjp6LKUo/YFgTu2XYG05dhpn2JPXViMEZG9AaQyj82xuE3xjuupcaHuQvx8s4dbW/LySf21t0IhMP1/5lClLr8ZbPylS1mtWRANEfmGpKYCKUTp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCUpQmEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCUpQmEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68541F000C5;
	Thu, 15 Oct 2026 05:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792043877;
	bh=77kXqfdfK/UbzPeN4y+WKD9H/CWorPUd+lU4D5rSDa8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=bCUpQmEuCLjuV7URmYerx4OOV/xZ6eZi2ss2fW46TMXyfTsERdh1ZRQrBwBFCS6Dl
	 JXKak3lJlh546yBBNQ5uv+mCzNPuLXXsSqmBsu1xGyWBTmjzAQh11qd7J6wHKSXev+
	 X2SBEL5c6Bsiqq/aHD+VAED6S8dwlT4opZl/sMYNOXjRMotOqtG34f3Be670akK2hO
	 AP4OYIUT/V9cNyDGVItJH84aRFemFLi1fi2ltZMkTb+pKYXuEzxfTU9tVUGzuTH4N4
	 8wkDc0JKK007Sa/h08wp8LNxAGqlL/b5CQwT1U7zgqu7+SgR5rJf4y5dVYIxuHgsiu
	 p6eSBCf2KILgg==
Date: Wed, 14 Oct 2026 22:57:57 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Greg KH <greg@kroah.com>
CC: Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_seq=5Ffile=3A_Require_explici?=
 =?US-ASCII?Q?t_initialization_of_struct_seq=5Foperations?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org> <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
Message-ID: <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 14, 2026 10:46:02 PM PDT, Miguel Ojeda <miguel=2Eojeda=2Esandon=
is@gmail=2Ecom> wrote:
>On Thu, Oct 15, 2026 at 7:21=E2=80=AFAM Greg KH <greg@kroah=2Ecom> wrote:
>>
>> Anyway, I don't know=2E  I like this feature, and maybe it's going to b=
e
>> used so infrequently it's not a big deal, but feels clunky=2E
>
>Perhaps we could call it something shorter, like `__explicit_init` or
>similar -- I don't see that substring (even without the double
>underscores) used anywhere=2E

That's nice, yeah=2E And it's not the first time we've changed the "spelli=
ng" of an attribute=2E

Does anyone object to that? I can replace it with that in my tree=2E=2E=2E

-Kees

--=20
Kees Cook
