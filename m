Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122642;
	b=i6rux4s3itFE5PWZzZ3eLG+S4+l6m9f7duXA7PoG0897r6Tj8D51PryqA2fETppyuikX
	 WTFGRc2BqzJ4meqNx4cXR3FPoOHkBenrryK48+QiCukT5NfXfAtQP5GmS9n+e4kBWn4wV
	 E7n+LgXWk/dSaxJ9pPJzqZ+1dK6DV7j2EP8FbVB/hTOZBoLCnaQ2RqOiDFEYn1dVurrX/
	 MIL8WIerjA7enJBp/5RpZSOS1ie8PbVX3CAURlYeAn5hdNG4MN0IYnDw13Va8koWVJKaV
	 ym3x7ZVJl9Tc55Td9SUgsncUxo6ZgjyICaTnJ07ePomYcePCwLfVCbBhyK0q4FS2BOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122642;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:From:References:In-Reply-To;
	bh=/bG8PkjYsvEV7J210y97Xlh7ZvHXMIdtFOS3k8KAa34=;
	b=DQsSEIXuWY7mHEQfzkFTPxUKdQILKgvpQob/0OuiEjex9eUPa3YwTVUSXUoDdIXCnFI2
	 4JQqWB7CDGYhQfyEO5PTjR/jLX32pKAu0eaGE8BvhzqtgWf6zloIpFBKKxuYSI3sILom1
	 utQpPjnc0WCA8J93kzJpki5y/ssg7S9Q8XqxUueC1LLdM4an1+2drQ9Yimz3FKAxKNlup
	 fVD0WR2akksxZqypQxPgzXwM+yOcDh1A/fHq+jA/nT9PpPD+MiRuN+PjlALtnZHjlY022
	 YcxAdwE+2yYlXvVRjYT6hfz9684s/ts2dserSQU102lOO50bDmQYCyudJhwtQmvtb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjUDbItY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AF606A325;
	Thu, 19 Nov 2026 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjUDbItY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D411F000C4;
	Thu, 19 Nov 2026 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122642;
	bh=/bG8PkjYsvEV7J210y97Xlh7ZvHXMIdtFOS3k8KAa34=;
	h=Date:Subject:Cc:From:References:In-Reply-To;
	b=kjUDbItYk/X5Iwau+pwe5JQNajGA1y6zNi7i2z7kKk3dXrxmRWP/1zZZ7jtoD1JMv
	 gI0xnZM8/dMWEC+c9Tcw0X6k0uFaLn+U7eApaGalOwg9NW+nEFvcskMeAGBBwaooMf
	 aY0zNBL++PVrGLNdzCAf6FmR26S+B+qdkMUpR6IgaakrkQ/kogNOGJ9jmhd7Y8Uutz
	 7f8zAc/g3e8irkHWVBZuHhPCNY5vnQjgAg1K11oeiOnDBUvGVaLL5ljpN9xB9UrPvj
	 YHB3lu1OfXZp/qyqPa6UmJMdUn/Cm7NJD3Cj8+Mtdkg8pKt9oITJ+M7cTuX+B14h3c
	 qJ33VE60K6QxQ==
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 22:10:36 +0100
Message-Id: <DMZHV6PHR3MS.1IMXZ5Z6SK7KJ@kernel.org>
Subject: Re: [PATCH v3 0/5] rust: sync: add WaitQueue infrastructure
Cc: <boqun@kernel.org>, <gary@garyguo.net>, <aliceryhl@google.com>,
 <lyude@redhat.com>, <daniel.almeida@collabora.com>, <work@onurozkan.dev>,
 <ojeda@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
 <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261118235039.3176436-1-dakr@kernel.org>
In-Reply-To: <20261118235039.3176436-1-dakr@kernel.org>

On Thu Nov 19, 2026 at 12:50 AM CET, Danilo Krummrich wrote:
> On Tue, 17 Nov 2026 01:14:41 +0100, Danilo Krummrich wrote:
>> [PATCH v3 0/5] rust: sync: add WaitQueue infrastructure
>
> Applied, thanks!
>
>   Branch: topic/waitqueue
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git
>
> [1/5] rust: task: add safe schedule_timeout() wrapper
>       commit: e18830073ae4
>
>       [ Use cmp::max() instead of self.max(). - Danilo ]
>
> [2/5] rust: sync: add WaitQueue infrastructure
>       commit: 64b7d9006106
>
>       [ Improve short item description of WaitQueue. - Danilo ]
>
> [3/5] rust: sync: convert CondVar and PollCondVar to use WaitQueue
>       commit: 4afe54ecfe50
> [4/5] rust: sync: condvar: use task::schedule_timeout()
>       commit: d4645430d9cc
> [5/5] rust: sync: condvar: add non-exclusive freezable waiting
>       commit: 4fcb2a2725ba
>
> The patches are in the topic/waitqueue topic branch and will be merged in=
to the
> corresponding target branch soon.

Merged into drm-rust-next, thanks!
