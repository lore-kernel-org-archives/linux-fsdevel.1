Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702917;
	b=EAC79Ia6/phFBlOOr3itBInjcdKcYktGLESZ59viYoEIL9rwZa976IGE3T5ML+9wBdH9
	 3ZItJlXYmISsjDq5P2PAsFPC2CY91/a4DBUf/+C/3o5x5Uo/f28B6CiYCQUrFniLCetWO
	 Jgfhp/ZoHQIwyZJ3CJTk96AFPlOGSxeF686JKLVZ+/RVSzgB9Q6TVufLYuqaLNCbYqEp+
	 EF1cFOhTwjwpo2vuapbK6lHZeiRxa55DjK5frsEUIM/LLfVjTooE5jwnP95LHJIxfgXrf
	 vkZGUkDioNZKfGbB+QWKcxmuYEai0tsZn1vMoiua9yq6yARCue6oEPvDfj5umh+vYKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702917;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vDrv9Rfc66q0u11nw2Ofk2AFrGnK5EZJAdaXF/Wufrk=;
	b=CMv5ZLngXo8suxTxKPDEaYCSNY8je3hS9OZVhtRVTt2mZ5K8PLeAuDDxeQHOC/W226C5
	 a3xB3E7oic/OXj5DO72Iowst1uTBWjzoyLAU2rmOqHaJVYosPxv6A32K+AldWeBH1mFCt
	 DRcZWzdERoKDOobmQIapKM3EVpXNCmrnaPmO9G/lwBUxnSzkvglTp49UfpOExSRo6n174
	 L+Rlmemxw0wKnuIVi1umWatMtzj1D0PqbIXoVxR2ek4B37TBiyQ1jKmOLrPweXVXAYMj+
	 tzxGuZCot1vBNqA2r8XcmVGzqBP51s/DM7zhygFc8h2Rt0IaqONztkrwuEQjBjobmxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8pcmt9U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D796606A33A
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8pcmt9U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E39F1F000C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702917;
	bh=vDrv9Rfc66q0u11nw2Ofk2AFrGnK5EZJAdaXF/Wufrk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g8pcmt9UtOsFI1fo9CxKbYPTzvsqw0sWH9ACzZvlMR51axd53xpfjIJHW3wwBJjhq
	 FFVA3mzmsjlRj+C1s6krHEnLtpMM9pDtWlKfCuGdddXd+8WUIwYX2wkDUE+o5um/Xh
	 R0P0QjTTbmMouATSYvV06/vhD9iuQMomja4hTmI1n4CDHkYoU9Kyqw4CR/7f+hjdav
	 TqpEA9lxeek3+otYFVTutJ8EzMNvgyVLTFd9Q4uWVBUmqS7k5s62pNOnHkImiXi2tN
	 zwTgVauW/K3/DOfeSeC1qpC2kUx9GFCG1zN9cx3+ZdFSBcQ7EcZCyYzd49AIzAJlgS
	 Ofb4GYI4WnJCQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso370711466b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 16:35:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGWsFzfHLhK64B4q+pl0FCYV10VaJQx3Mnsv33Lwp6bPj9urRL3P9FgLDaJYknPpF5YFBegxZnAZw88mvbj@vger.kernel.org
X-Gm-Message-State: APuU4Z/EnjCRwTUtzbtA2/ot7NjMbYFt3HTELH/QVbIcvNunv2Tlmsxv
	+xqb57kSJvCXomenOOYPDDvk2PqBEU0Ke6vDOKXL5M2B2OMkb+Kg1trhKZzJHQkJSPmowLuhDqq
	4FVm6EpdTrHOk8RRSZFGgNi8Op5pNEQ8=
X-Received: by 2002:a17:906:c114:b0:c46:8913:d89d with SMTP id
 a640c23a62f3a-c50962ecaeemr500449966b.14.1794702915613; Sat, 14 Nov 2026
 16:35:15 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-chipsatz-gutachten-geklingelt-81574928a5f4@brauner>
In-Reply-To: <20261114-chipsatz-gutachten-geklingelt-81574928a5f4@brauner>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 15 Nov 2026 09:35:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd91kBcAJTwkP11gN2igRkv8w_4sFgyxbtiCDhkVeLgs7Q@mail.gmail.com>
X-Gm-Features: AclHuK8d_OZBXGk4HXH5KANpQvxUhIOawFDebvYhDrOGOjv-Cq0-UfMC5ZNXA8g
Message-ID: <CAKYAXd91kBcAJTwkP11gN2igRkv8w_4sFgyxbtiCDhkVeLgs7Q@mail.gmail.com>
Subject: Re: ksmbd: SET_INFO modifies frozen filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Jan Kara <jack@suse.cz>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 6:38=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I'm working on a freeze protection series and this is the part that
> affects ksmbd that I don't just want to fix myself.
Okay, I will fix them.
Thanks.
