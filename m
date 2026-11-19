Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085236;
	b=Ae53FCNHlkvBdPIZieDU9cdkD9acjoamqgbb4veOnIJsuYk6D+ao5pec1ELlcezp5poy
	 PmB8P1rc/XzV8mosmA23QtUuhugtMfchZQnp7v+arhKedASfAnf6+EWtvU1uwA2A2i9Jb
	 cerp3/w2c5MuuEhhvRtPVq7JqMsp0M17orzI+pmxyuWjPGa818QnNLx6Tfj1u1tEWNLXm
	 RbildsVjoJC4A/yMJ5jFz802vls7xkQvE/L0IjSEWJtQ5bPB7qbjqzpSeGU/ndZta/Vc3
	 hYmypmV2YlhiYiT0ejoRoxn7RTv3EPXEPDLdxebfpc01/HSpd7543w7GT1YgrUVyAmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=67I3bNEfcu+N7yXs6EAi+/lBjbBrobM44S6SPv9jyFg=;
	b=uIM3USUszkewKxKdOQGFm2c5v/UkQGMrUV9XeCEHuRU4n+nYKIPpp2F4d+Aa6ck3nOPD
	 QJxDxxMecqOQ6cgk9uJ5k5kCUiRlfzpwc1Y/733rMLMBzXSc/94uMG6CD6h8MS64C4y0M
	 vmJJjcdar22hwafoL65rwW/S6abXli4uE4oPTdcKijN1+B1U4+WQ4rHDxg8FuJA2+/A00
	 r/JdTrXDdDr2AQEJChslDdH0bmG6bNUmf6s3RNfSL01VDE5ju5lUOT2yO9jEa/x8nY8X7
	 lSfAp2YJ85xz6lnuuQ7/HyzKXFjN2jEJiiQafPgn6Cw+T/7u+z5vjaEgDKUlWQVEiWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NdNKDppB;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B682606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 10:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B682606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NdNKDppB
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so21772075e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 02:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795085235; x=1795690035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=67I3bNEfcu+N7yXs6EAi+/lBjbBrobM44S6SPv9jyFg=;
        b=NdNKDppBshR3yFJ0FfbOWsYgjw9irAEaVT/7IxVBjACSprcjw70nJAaThe4TTE+dBk
         UInzrM8KIqiFSmvFBXVwwQFzSfHXLRF4YLznNEgsA197A1YdVcYipcpKCnel74Lh3uP3
         IJU8KmNQDE6rlRrjF6eygat4qW2/xwIgaKCTrFmzkS0v7LtEztyWb9t1xJsPCF5aMRuU
         AIOVlCWj4gpRfMcPCpCzLg8bap7PiOOE6JeYbZy0QxdKAoWH1AASpuiixOTlS7ayd7/G
         VorTt3PcndgbOdBiGT0Q/3kekAtTPAvN9t/QClLjiNey7MLYcj9IijV1Jh+gIk3Z/tIK
         upLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085235; x=1795690035;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67I3bNEfcu+N7yXs6EAi+/lBjbBrobM44S6SPv9jyFg=;
        b=aYMsQJNBDWXsbMjde7lHfPrBsdu/q2HaOlx5uxwNyvR3bdoWfZZFTkDWkTcd8b4gxs
         FHpC1ad/03Mosf1EWK85kZQYxE/1KV0heDzXmStc9aaFS/YfZRjGtoSbZ+0b/9xCQZCn
         XD5zw4l/RtvAP+G0R11xSt2RLnCGI9F1z/g0HaHGiZeK2GPfCjNbGYsqFCSzgk0AyFSZ
         NyBRw0F26q/RlNdQAaMcPbBnf+AzCHmUOe/okDExzvkhVbZS/hKUYPWms8dZ0koq/cht
         qruJcuB+uZqSSDMZkc3m3qUhZhfR25u4TchEtmx54Uz4au83AVqsgUQJu/BHeVNT7JWO
         lM0A==
X-Forwarded-Encrypted: i=1; AL+hErE4E7TqUeHTbkD8tm8lgUPOlX7dXLxAPCs2T7yPw2RC/b+AvXVy9bgKnoJJL8HgyyIx1UbzrGIjoPPyCHXS@vger.kernel.org
X-Gm-Message-State: APuU4Z9oa83BRwE1pom2D40V/6aPJ3ow2nWUfebFnC2cNnSAYdIEOgZD
	BEBa7Nr+7PGzHWUkTMdZRcN6c0EPnq8fuM6f+J6u+3wBmhHDR+P4bWpQYBSN810wPbHMuXx1xQ=
	=
X-Received: from wmwb7-n1.prod.google.com ([2002:a05:600d:4447:10b0:4a1:a2ef:38dc])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e56:b0:4bb:7581:2bb9
 with SMTP id 5b1f17b1804b1-4bb7da3003emr104763395e9.22.1795085234352; Thu, 19
 Nov 2026 02:47:14 -0800 (PST)
Date: Thu, 19 Nov 2026 10:47:13 +0000
In-Reply-To: <20261118.faiBee9Taigh@digikod.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <20261107.aighieG4Ami1@digikod.net>
 <20261118.faiBee9Taigh@digikod.net>
Message-ID: <av7TsXKUE69lyiWl@google.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 03:43:03PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Hallgrimur, could you please explain why your use case would not work
> with Landlock?  The capability split or new clone flags would be
> complementary of course.

Apologies for the late reply.

Landlock's capability restrictions work well for self-sandboxing
applications and launchers. The main gap for our use case is setting a
host-wide default for unprivileged user namespaces while still permitting
exceptions. Because Landlock restricts all capability use (not just
capabilities acquired via user namespaces) and its domains are strictly
irrevocable, PID 1 cannot apply a default policy at boot without
locking out privileged services, file-capability helpers, and authorized
workloads. Using Landlock here would require explicit opt-in enforcement
at every unprivileged transition boundary (SSH, container/job launchers,
etc.), where missing any entrypoint leaves unprivileged user namespaces
unrestricted.

In v1 we had the global sysctl to tackle this. In v2 (based on Christian
and Andy's feedback), we combine per-cred cap_userns with per-userns
cap_bset), and PID 1 or a service manager can lower the default userns
ceiling once at the root of the process tree, while privileged tasks
automatically retain capabilities held in cap_permitted and can
explicitly raise cap_userns for authorized workloads unless locked.

Another minor difference is visibility. Clamping the task's capability
sets on userns entry (and exposing CapUns in /proc/<pid>/status in v2)
makes it easy for userspace to inspect what is actually restricted.

