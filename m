Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921256;
	b=bzHRAUMhN7f6vTFAo6wMeILszjYlc+9ZnaK5hLp50/sSma7jz646HUSmhxDBhND0cTBY
	 jPeKTUTkfSQN9qfsOQt4cp45gF3pQRpgZTWCBDoxtAeQzfaKnFxWqUwrIiVcfk7vV/oC7
	 LaMPSfDe3vIrO7ZfaMeg2c3DCkm/YttRhak7pX0DZZcjoQDhMZHrG91yq6r/qZHLyfQVJ
	 T6YlIgigS4JyJWlRLVno9CiIxVZ6RQGVw+FsSVyAQkk32XLP+ekgqLwChYebgmI9KXAIM
	 1ePqhNQsYmih5evFh4DcY9/i3axpZphJ+1EOH+SlwTF5CbajLSkXNyjdp78MPmSt5cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921256;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To;
	bh=esDAPkgPyi097rGtu2NlFyj83v6KBu1QCQkoO5elA4A=;
	b=04uMG550xZ5e0pp/SNlWiUvibuuZqCqu0GP+TJmborfnxm+3CkXBoMIgNrH9fiZJDKzk
	 9at135f/r21KHpsxNTEdgW0ncKN9U+WYx/++4ABK/HG0QBSclQqwesGD8QiuZ5uHRzhHE
	 D4ZttM8uM5pMlKDWN3X9IRZpkiEGoFU23rpBQNexFTp1mw6jxkU9hutv4qwUw2muGARfS
	 kmpP93L7g/bxi0FrdB9Yd3u4OvnENiIvrehlRAd99J0Fp75b6g2Bid0ItfR/jlr+UDjrt
	 RmFcINKR+yW+PpP3C2CVb82bA39SKbq6CHudP7Z3AmfLxOkM+0t27i/zGXD3OKtqmkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0qy6k+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32459606A31C;
	Tue, 17 Nov 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o0qy6k+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED801F000C4;
	Tue, 17 Nov 2026 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921255;
	bh=esDAPkgPyi097rGtu2NlFyj83v6KBu1QCQkoO5elA4A=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=o0qy6k+ClRxsVrNeII8VK2DxW0z7RF1lJUs96JG4m4PgPtHClFXc3F14FySKl15DS
	 6sqJ32GlxjNcbngtKtvZi7YWV98XOGBefybmoePtQ8jwZQprIlWJxVTC1dmFXMFQTe
	 /yc7UaVvcuOJ9hvc1pj3WkUpuyFGwJ8TJpjPS1kr1uy1dZlNt4ojWzH4haflBOg9Lw
	 OZNQrhCf3UfCn30J6QPwOdfB6e/T5bGIcKoOfmGGVt6tW2Q9AAo3xR8XYvy4Gre24U
	 X+nRoH1C3xx5TnpdVYuGTqc6WNrmGiY4Vl+Brp8QepsiIVZyJfyFeBOVcCXndaTPLD
	 WnaH0/zkegZsw==
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
Date: Tue, 17 Nov 2026 14:14:10 +0100
Message-Id: <DMXIHAWC8YGT.33OH5RY5OPPBE@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/5] rust: task: add safe schedule_timeout() wrapper
Cc: "FUJITA Tomonori" <tomo@flapping.org>, <boqun@kernel.org>,
 <aliceryhl@google.com>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <ojeda@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <acourbot@nvidia.com>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-2-dakr@kernel.org>
 <20261117.094531.2139684707820199268.tomo@flapping.org>
 <DMXGHLYADENS.14LHK34JTZTRX@garyguo.net>
 <DMXGTVTETSCB.2AG2E0Z05QT03@kernel.org>
 <DMXGYAQZB33R.4BWEI96XQXL6@garyguo.net>
In-Reply-To: <DMXGYAQZB33R.4BWEI96XQXL6@garyguo.net>

On Tue Nov 17, 2026 at 1:02 PM CET, Gary Guo wrote:
> On Tue Nov 17, 2026 at 11:56 AM GMT, Danilo Krummrich wrote:
>> On Tue Nov 17, 2026 at 12:40 PM CET, Gary Guo wrote:
>>> On Tue Nov 17, 2026 at 12:45 AM GMT, FUJITA Tomonori wrote:
>>>> On Tue, 17 Nov 2026 01:14:42 +0100
>>>> Danilo Krummrich <dakr@kernel.org> wrote:
>>>>
>>>>> +pub fn schedule_timeout(timeout: Delta<Jiffy>) -> Delta<Jiffy> {
>>>>> +    let timeout =3D timeout.as_jiffies().max(0);
>>>>
>>>> In earlier reviews of my patches, Gary asked me to use the function
>>>> syntax or clamp() for this instead of the method syntax [1][2]:
>>>>
>>>>     let timeout =3D isize::max(timeout.as_jiffies(), 0);
>>>
>>> Yes, please do. I'm okay with either `isize::max` or `cmp::max`.
>>
>> The examples in [1][2] both seemed to be able to avoid a cast with this,=
 which
>> isn't the case for this patch. There also doesn't seem to be any ambigui=
ty in
>> the extression used in this patch. So I don't see why changing it would =
be
>> better.
>
> The ambiguity is "the maximum value returned will be 0" and "the minimum =
value
> returned will be 0". The answer is always the latter but I'd avoid the me=
ntal
> gymnastics.

To me clearly both

	a.max(b)	(1)

	max(a, b)	(2)

read as the maximum of a and b.

IIUC, what you are saying is that people may read (1) as

	a.at_max(b)

which would indeed be equivalent to min(a, b).

If this is indeed commonly the case I'd suggest to raise this to become a c=
ommon
rule (ideally with a lint), such that we avoid this to be discussed in revi=
ews.

Personally, I prefer (1) for the expression above, but I don't care too muc=
h, so
I'm fine to change it. (In case I don't need to respin I'll change it on ap=
ply.)

Thanks,
Danilo
