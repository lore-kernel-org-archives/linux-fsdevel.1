Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916600;
	b=ePSN2+pIHDDHf6OT7QNySVAxrc4Dh3zo4doE8dS5bnSP4GeLAcoTN21DPx15WiOwiHqT
	 KEkasxqen5e2zwao6LanTWzY/3+ciQJBiLCuuHzd75QX+fg8hQ4c5SzPbL+3LxDbrAHjj
	 67KjZfOcLdobZUZXhUeXtU8jun/fqAuMArtizN/A10WUx+qty5ggD7sy2MAEEJwkjAhPi
	 ICJPMpsc/qj5QoOQBINHk/QA6LaNzL6dmUK3gCrDsWJfkw0+iKfeJL81sQZhZcK0s+1zw
	 qr5xZHBAZfvKgW8s8aiGSO567t68nHSDD9IxTCNl+SajFjU8NHvqQaMpCC1fszp1jcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916600;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=umxuLlZAwyE4AC/AZRfzPdw85x0X36ZAr7Oz+hwigXE=;
	b=BUAUHXnW6SxVE8EZ4wILGa69jTm2JujY+NQivOrPjDIVxGBbNEau9DqEK0GvNiDswTSC
	 N7/8MCmCPgQ9wRS618bJoc11B3s+a6IgkFMsHqEeFPfHrv/X8/hAwJw8zJy6YLMXbmWUP
	 LNV7iaqTyql4Nd0gVnr5dE2vRcyapEU+Y/VvkGSFB/o2sA565IdmkQQ+FAEOVlZW77gxf
	 ep1v/s2QHM+TfvvqYqJIiNqh55/bI5yYAUnttwlTguJtXnAUuDwHvVCGsaZQ43QGBIu7w
	 4zKqazF1Xa75ZjnRNZqj9owFDs/+2C6muCpmuCPjbEUFqRBX/nI2nhA/B/E0BgM1Hlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5AWH4Xk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5F606A331;
	Tue, 17 Nov 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5AWH4Xk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA8D1F000C4;
	Tue, 17 Nov 2026 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916599;
	bh=umxuLlZAwyE4AC/AZRfzPdw85x0X36ZAr7Oz+hwigXE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=d5AWH4XkfcNGFEwWfiz5kirzqn/zMtBq8qMYYerhMQBhJCdqQcaGqGojcfxbU3G5B
	 RuN/fZnGvNDu3l6CN4oZZ0qqA2efPb0LjkPaUm0XkHj5sV+S7W/96VHo4LZod9yjzB
	 MS/f1BP8I9JPVGKnLEIrhhv28PBi9M7Q7Isz76Qm3s+yTC3bDP7GHJ1aV79qhqFDda
	 sixd1/uWomRxQqK9eT5w3AfwaRaNewpRvbYjP5wUDxwpHjvb2+IiwejnC4VfyNkkcU
	 jL3RHivlbIjzB2w117tVVKH3DO5ETFcQKkHlT7FeEGXP8LLyizTav1/WzeT4Z/TzKf
	 vg05FoRX+OtLQ==
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
Date: Tue, 17 Nov 2026 12:56:33 +0100
Message-Id: <DMXGTVTETSCB.2AG2E0Z05QT03@kernel.org>
Subject: Re: [PATCH v3 1/5] rust: task: add safe schedule_timeout() wrapper
Cc: "FUJITA Tomonori" <tomo@flapping.org>, <boqun@kernel.org>,
 <aliceryhl@google.com>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <ojeda@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-2-dakr@kernel.org>
 <20261117.094531.2139684707820199268.tomo@flapping.org>
 <DMXGHLYADENS.14LHK34JTZTRX@garyguo.net>
In-Reply-To: <DMXGHLYADENS.14LHK34JTZTRX@garyguo.net>

On Tue Nov 17, 2026 at 12:40 PM CET, Gary Guo wrote:
> On Tue Nov 17, 2026 at 12:45 AM GMT, FUJITA Tomonori wrote:
>> On Tue, 17 Nov 2026 01:14:42 +0100
>> Danilo Krummrich <dakr@kernel.org> wrote:
>>
>>> +pub fn schedule_timeout(timeout: Delta<Jiffy>) -> Delta<Jiffy> {
>>> +    let timeout =3D timeout.as_jiffies().max(0);
>>
>> In earlier reviews of my patches, Gary asked me to use the function
>> syntax or clamp() for this instead of the method syntax [1][2]:
>>
>>     let timeout =3D isize::max(timeout.as_jiffies(), 0);
>
> Yes, please do. I'm okay with either `isize::max` or `cmp::max`.

The examples in [1][2] both seemed to be able to avoid a cast with this, wh=
ich
isn't the case for this patch. There also doesn't seem to be any ambiguity =
in
the extression used in this patch. So I don't see why changing it would be
better.

Thanks,
Danilo

>> [1] https://lore.kernel.org/rust-for-linux/DLMME4OBH3P8.3Q6UK95T2WGI@gar=
yguo.net/
>> [2] https://lore.kernel.org/rust-for-linux/DLUDG2TH77RI.ZQ0T5MH7Q573@gar=
yguo.net/

