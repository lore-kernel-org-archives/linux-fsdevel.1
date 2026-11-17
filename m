Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953188;
	b=joZOO3wj5FXDDUS8Jp2n+FPBYlX1c+smO2iXRkFNwxItIxTy4aI6reyIS/KRUgcmbovV
	 GUMhz8UoDoEWBpu6pZAstHKw4eBTm11oqOuIzqQTU/OegOEGtHl5qJCqevHqxWrsAeeix
	 HIfkUfK0ThaB7fal1bij7xYGT+D3RL4piwKziZLttsmLqeB4Q8PiXNqQlGy4GIhdKp4yW
	 a9KI/DbXEasXH5cYkJhvxUb+rlZfl4cmFfqtvMQrPR3hnWgKeSkUMTU0r4i0jOwXPyT4H
	 1itsPnjqqui5Gfza5/48rBmzcxRHIW6pF92FpGHFMZmnCDF9bzYKNVy/2swOFDb/Mrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953188;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type:Content-Transfer-Encoding;
	bh=ygy/EyAf0W1UdMvHNYbKmsjNOyLB/rxm+C1CVbXru9s=;
	b=juJYwf0NckCETygKfoRj53dW8Vcxb5dPk5SGS5NFspcSLscHQYsG8J7iMx3CtifXIli2
	 RWuvpIqZyqQ7NhK4h6ctvtwxm92yCILP9lYQ8YsK55hwd+3ighqE4gxwVdj1PTjGjZmcI
	 FQvGlQljN83n3By45n5l7m4NX2zqQzPYl/EYB/tH1BOi29ChqLl9APDjnzTnmcjjng55A
	 KUX1Sdp8byoVq3pYDHDg1A4VdfVXeBUBu1RkRe5B6YvopT6yzBm7r5ZivuOOQx2Ut5pKH
	 NQEx8jiFZX5fJZlwI9EoxLSeikSo7XxFeXuid4eeeFZ6xGWM16WmIkHlEQ4vsV2BmGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=G121a1Y8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=txFulTox;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DD606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 22:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5DD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=G121a1Y8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=txFulTox
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EDB91D002A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:06:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Nov 2026 17:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794953183;
	 x=1795039583; bh=ygy/EyAf0W1UdMvHNYbKmsjNOyLB/rxm+C1CVbXru9s=; b=
	G121a1Y8/0uM3w0nEs29wkoTvNSuBQjZFUcJtTed1QGRd6HfUczndaSd2v6CN36y
	r3EyXPB4QUtN2Hhji0V8u0U2vzZ29c52jPL5Q2pHopgVerUjIlMyl3fRMmnwSRH3
	vBZ4No2gqcqfeJiLq5yxP0BwQt0gXVBNwfjbCC47Itz6Exafv4h8FwiztDIcgMzY
	ldPpCWbnlbh73c8mXGsuULhN56fnS2kLyFmfgYCk/dD0Y6s4S17TZ688vmZC9bWr
	OSY6wNoGaIzUsh2xNZoQ0n9y10+6OQFpT9IHMNDXtyz1l+7CSS6mGKhckALMO2TG
	oYQMOAahKUH2H4kltfBLWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794953183; x=
	1795039583; bh=ygy/EyAf0W1UdMvHNYbKmsjNOyLB/rxm+C1CVbXru9s=; b=t
	xFulToxWD8Kyjcwpp2qtvywA+dmST6mYl+62/TNKbnJZkPa9foilulG3G1nTYiHA
	xOoywPO2XcTHZony7D4f0w57CnAG3kAhuetgSKENGNn+oq0q0WTbsPKCQuXqqRhG
	5ccsx8kHwztr33mXHHGrOo7MeJ3LLwO7unAE1lnRqgCTkie2K6f0te+OdvVHwNx0
	TcGMBXam+CZ6QbgStQif0LFf58xPNSH6kYAqDArte7PIqqqJWEcpKZ/WwMfBazp8
	854MF7CDdyyCwUffmRe/nkCMnmW1my54cJNR/TUSpAcEn0Lo2fKiqVKf5hANKu2A
	Zmw+1YkVFIHAnPo06TfdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794953183; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:d4p5+SjpIL6zPyEdR/drHYQK+4flYy4JcvsG4Be10sbv+9l
	kIX8a6TLv/Nf1ZEs50jq1pkolWRRD2hbxT4w2OK0Im6LFAOF81RMr2t4A8AwqmPY
	BO5ZQxf/357qK6ZTilVGRUNZW/6CxkjYEFOWcOhTAx+nTEjhA7xfrj9KIblLup21
	zFIoJbXkGExU6rV2yw83PyaoQmSOItViGL6YxKvdvDtZItIVoUf0JhKVEonWsoeP
	y11WgqehAljeWFoU4MlGk6N6DJslS/Vl0mtYWNLfHN+WXpVABNJzsxHvdgy/ulTi
	3uc9FfUltUN7g/lVfeIVzr1lvxoZpemacpTNDcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2Tb1pSwErTgeSPF9fdAxkhBNeg7qsCKbQa3UnyjpHKE=:eqdSGfVVdOx4CGbTW//ANSk5CtWV6ls4JphNeLvrvl4=;
X-ME-Sender: <xms:3s_8avSPw4kVrxefZqI73KKLCAUCnprZI8yaYSrCUBI6roGxjaliTw>
    <xme:3s_8avJs_PvmH7okHRR7s90KGeT8K0vCXQgzsUn3FKeUIMKBzir19KFk5CjbAC0-X
    QoHlmfj7VXNa4V4LMBEqg07EN-bcmf0lZAu5RY83-7eev_LUMuZlFhQ>
X-ME-Received: <xmr:3s_8ag2I39oK6Ojn7zQQq5iK_65xk59WibG1oURCiVzSyXYtPbBERhEEGN9ARdFOC3FpFR-QgLogQP3dX5LEo3FX>
X-ME-Proxy-Cause: dmFkZTFL5mZp+mTX6WVoBC0YPiYwbLINyUT1n441b0vqnathugDg1rVMsVsRRzhLkJP+57
    Ot0TXwORG1TM2AEh2E44VOxlhrRYLZXrkB1XYc+Mx91FeQUaaLUlbgggrAAKe2QWdw1m/9
    sasBo/8b5PW3pVQYk9Oaljvf+ZOEwy9gqQW5V1jVhk+YhV2a4GFTWaMjWPyZsyYb6XoqMr
    U+6jWvK6G4YiY3q/1oY8qVkRj7F5b1ddWNdG6qJylKGDhEbNkvFdZx5VFKeJ90dCes2Djk
    ZPg5LOD9aZU2ECwndj9YfIYwYk98iuha5s8ftVBnsftMMFpZ2BIqmVuPjf+95Pr5/U4xa/
    k7Uv6lLFs/U3yo9FA5h2bQCMznOuwfF0kSsH7Tb+ddw7sqkMSr+dFqsA6oYLIL0U/oXGkr
    piCfhH6m4SloU7DQGh/8Rc/mUeT36cA86i6coKhMpM+1lDMc6bw0uA9QNz0GTE/lg+Se9M
    y+lurogFT6UmutAM41KCA9EbqbgUNsh2QNfOLLPpoV/UU+ImPaMehzfSdUeXC8rHUgFbOm
    xd2leKeNTCSx/fXOx0FG/oj3WtlUwcOPrS9vy7W2n71+0SfHun0UnMXTVT9snogQxX2Ltx
    Iylcek7f/qD0lM7rR5CjCdBSni9twAnWZix1mUt/r7h2NRa5w1VHcIiY5EhA
X-ME-Proxy: <xmx:3s_8aiIywHfO8dC8l-y-wVbQR_gjeAnQA2k_wasoBWNobT47y7K8iQ>
    <xmx:3s_8agkGAmcApoAgI7meOymGBgPscuVnANnW7xjRYQgOoE1EAau_qg>
    <xmx:3s_8agNco9Uk2JKLvb_6L-8bvGGBqUJlviW7uwOTAeGtUbqepT1DPQ>
    <xmx:3s_8avzstqYeGf1ts7YS-V3TcBeFbVeErUaChASrsyk8-mqijUG-iw>
    <xmx:38_8aoKbPAOphh5MlNYeJ9W0zmO1Q-BuxsGlZxL-SH3Fb2-fE2Y9ssSb>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 17:06:18 -0500 (EST)
Date: Wed, 18 Nov 2026 07:06:13 +0900 (JST)
Message-Id: <20261118.070613.2130514405871522599.tomo@flapping.org>
To: aliceryhl@google.com
Cc: dakr@kernel.org, boqun@kernel.org, gary@garyguo.net, lyude@redhat.com,
 daniel.almeida@collabora.com, work@onurozkan.dev, ojeda@kernel.org,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, tamird@kernel.org, acourbot@nvidia.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] rust: sync: condvar: use
 task::schedule_timeout()
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20261117141652.2992350-1-aliceryhl@google.com>
References: <20261117001507.1611984-1-dakr@kernel.org>
	<20261117001507.1611984-5-dakr@kernel.org>
	<20261117141652.2992350-1-aliceryhl@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 14:16:52 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Tue, Nov 17, 2026 at 01:14:45AM +0100, Danilo Krummrich wrote:
>> @@ -122,7 +121,11 @@ fn wait_internal<T: ?Sized, B: Backend>(
>>      /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
>>      /// spuriously.
>>      pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
>> -        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
>> +        self.wait_internal(
>> +            TASK_UNINTERRUPTIBLE,
>> +            guard,
>> +            Delta::from_jiffies(task::MAX_SCHEDULE_TIMEOUT),
>> +        );
>>      }
> 
> Now that `CondVar` uses `task::schedule_timeout()`, all remaining uses of
> `task::MAX_SCHEDULE_TIMEOUT` wrap it in `Delta::from_jiffies(...)`, so we
> could also change `MAX_SCHEDULE_TIMEOUT` itself to `Delta<Jiffy>` (either
> if you spin a v4 or as a follow-up). Either way:
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

serdev users need this value too. I was going to add
Delta::<Jiffy>::MAX for it, but this looks better.
