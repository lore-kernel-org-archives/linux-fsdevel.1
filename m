Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4625EF87
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271586; cv=none; b=N8fVY8uBRnH5FNi8a4meLl1lQepu+AXXhAu8HsIdID5NB1Kk7yCoruiaIKk1HpkSEL0/oUNrZ7uey3M8HJIo6OrU/m+0KI2Fvw6pHrI0xbI1wPfjcMucv1dJjROHMOAGo/kTBZklAI+I1tAJnEj+k3trBwfjYVURKM9Klp+HAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271586; c=relaxed/simple;
	bh=VP/gGMDozSqT2AL1SJfVFUgY+nZxZF6RCY9/tR5JgHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSCUd7AR3dAHA7C3GWj9iQrkH2PBJjfB542bomuXGpm2dVflKATW9M9kUpG4SHJjz7iM18Rhgii8uiDX6Ei/Sc3M1dywvUInSWwLa5pVkOqKbhRjtByWQ7uMrSM0bZmvTGheFyisJCBeHa3cgXyl1owdnRMNPpew3urwb8gIl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ55qjrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ55qjrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3022A1F00A3E
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271585;
	bh=3WyGEHaF5o7eozrniQgUzGRum8jMmRL12v7aD8715IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HQ55qjrWnGeMgvY2v0TO9VjlJdOCYTlCulVXiypqV9F1VdYnSSZLrcE+3XXIWwJlv
	 Au2ktJOoYgdvvZyMG5ZEFaQB5CAG/EKkOp5tEXAo6Pbqnf/EqYxYZDU43eWPyZ3x0H
	 6MTEmbn5SawAfA0QFUApyQi/zj8E/QZXg+lndaX27wJCARHZh3mvgV/P+HiPbImB+C
	 BwGdyi/bFF9rV6D4DCGI3WtrXcdoowDnVMVfKOa2CQwBvGPWBpnHDsmPKusQA7zPLm
	 yZ/uiRa+RxcRvSvB581ke9CFnHNSdovvXzXcXeHfLen89gZzclVioLO1dfuvXxWydN
	 3G0FSKZvBoghA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20363107f4so47898466b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 17:19:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpstyqKEiKqHL+u36r6z9FnH6ROQKbI4+FSz6zv8+CqqHMUmzles2V07ICb7lQeOpFYKCX0lPfQwXNy/uXw@vger.kernel.org
X-Gm-Message-State: AOJu0YyseAQoOFcjtSBwDtRFgZWJ3LLHmMr38iu2VZ5MAGFseBL3tW+c
	/3FVlwjx/z+/RnAK6WyiPRJ34YGyu+4AfwZ1URUdWtKuXJiWFsimDkDmTYG6LtpVa/SFyL1nfsE
	bB+HzQFQ+irEhTjsYdqsrg2LkHjGYOEE=
X-Received: by 2002:a17:907:ea8f:b0:c20:ff26:336e with SMTP id
 a640c23a62f3a-c246a605cb7mr213550066b.14.1787271583855; Thu, 20 Aug 2026
 17:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a869f9e.c86fb4cb.55bb8.d1d7@mx.google.com>
In-Reply-To: <6a869f9e.c86fb4cb.55bb8.d1d7@mx.google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Aug 2026 09:19:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+vL5hePkkb5fbA1ffJAxDQjC-aTovM9ogNyH+TmDykw@mail.gmail.com>
X-Gm-Features: AcwNN1WBPKT2jKmWaf8mZxfTqexn4pBGCL47F2i1Y1IjyL5pyFaEnB5EyrlSpMM
Message-ID: <CAKYAXd-+vL5hePkkb5fbA1ffJAxDQjC-aTovM9ogNyH+TmDykw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix off-by-one page overflow in ntfs_decompress()
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 3:33=E2=80=AFPM Dennis Tighe <dennis.tighe@gmail.co=
m> wrote:
>
> The per-token range check in ntfs_decompress() uses
>
>         if (cb >=3D cb_sb_end || dp_addr > dp_sb_end)
>                 break;
>
> so dp_addr =3D=3D dp_sb_end falls through to the symbol copy
> `*dp_addr++ =3D *cb++`, writing one byte past the destination page.  Sinc=
e
> NTFS_SB_SIZE =3D=3D PAGE_SIZE the destination is a single page, so the by=
te
> lands in the adjacent page, and *dest_ofs is left one past the sub-block
> end (the later `*dest_ofs &=3D ~PAGE_MASK` then yields 1, not 0, so the p=
age
> is never finalized and later sub-blocks keep writing further past it).  A
> corrupted compressed $DATA attribute thus produces a bounded run of
> out-of-bounds writes when the file is read.
>
> Break as soon as dp_addr reaches dp_sb_end; a full sub-block still
> completes, as its final copy advances dp_addr to exactly dp_sb_end.
>
> Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
