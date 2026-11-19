Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115996;
	b=AG/p1tB0TQK31rhpmBb3NbdrwxpkWbhP/0rdylu/svPFtTIy5HzGE2r+hPxmU4yk7941
	 nWdrpIVqqJB6Yx21bH6Z25cllv33dtbfbi9A21nxumXCj9abu5e9nGPpxJlMN5L3HxOpv
	 7lOkPLdtM+XMy+PEUo5I0bd6EMSmyfkk1QrKClD/NsTzO1bV+bo2H+I1092I9Kb2gUKjC
	 OcTRpRN0kTqHp8/RREzhqlIq4kdquqg+M9y9tWKbuunCZQLe9I0CWbm0+6CP6S7N5pgJZ
	 CTtx2IKggM9RKeBH/rlXuw4cu9/1Y+mJ8loLgIo/DqVSUk+ofEevh62NDs9blFSSB6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=B3fPYwtnhJtRTzUId1FsxU5BbcK59iDRRgRTHG4g8TM=;
	b=EmqmgN4X7NpRccFxFQg1F+6TyQnStk4SUUUC0HqdgSpdVIPp2avW5jA1WyM2hM1oPJ2G
	 MLv7wSJbTQYyK9YDCha4bMYIMe45Mt2rxebnBynSg7b6GHSaDhSgzI658+2OxyeHiLltR
	 fBc9vWkQmF6uUhX57PzMcDqZRdKsABmmOy1fJZfuQGJ8+MaHOhHGkiiRFg/Z6OfL9IkQB
	 eFZwsFDgmOX+nYu2Oi+Vpq8YVaq5r8WIQd0/FRzvMoDga1iIQ9AZOmpbGB5jRMyA0UtpV
	 iGvoRmR2GtztTfaHseYwa3Wd3tZW9boS16Ar0+lzFwd/hpg8noFKFJbPYzt7gcZWY2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e6cswkqt;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89938606A331
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89938606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e6cswkqt
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c49b95262a5so7694666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795115995; x=1795720795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3fPYwtnhJtRTzUId1FsxU5BbcK59iDRRgRTHG4g8TM=;
        b=e6cswkqtbr5gIXT7zPqwbxbqDazMSGSQh5brqg3woxMXmbrKcsjWeeblJDpIszQpxv
         TGd/0ALnpNpnRp60nZIXkRb+MGUi4YpzELfsgyKbr4pDwt9UXKuQxAM8wTMa71F87J3J
         YYQ7BIp9fnmNRMjQDqTpqrghxE77fiw7x7nGb+4Wy9iKCcQm8Xc//n2/a/t+2OZIFVuz
         vY5oy9BS16JZ7A7CoPwlDpw7vJHOvZMFy7JAayuM8duhreLgQWZdUtjMkjojacGMmAPo
         XWy8bVfUa3GEHukBLrYA+VA8kAgfdKRZvXiR9bpIv8Lbshi6/T1qWH0+rQhWll7dwZeB
         FMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115995; x=1795720795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3fPYwtnhJtRTzUId1FsxU5BbcK59iDRRgRTHG4g8TM=;
        b=WlgP6aRlse9MHES+IdZl1zDaE1FTm1nlYJPMi5v35TQBOrOc+ZNFV/CdTVK49GCNST
         QIGhtv1e20MHUFBHkZR3ZNtr3RAUPGaPk0XnK4QaJhNgDg9WePZDdJx81ZzwUUcuMN80
         DPbb7cxCZysQXNOYYzohNKsmKbUxvcE+2mfTLCAsz8VbT8/Bkl+m5kH2h0y25/SphBES
         Kr0kCMsSXljb7cbsHzZMnPfJaFpg/0HQYP8f7/hfiGovoceJ8qce8vNxccubH7tHE+Rh
         NxB8oz/W3D5VZIWlJX3K/2grnl1Iij8oc9+ydvMG43ljgPx4dSRaxdTuxCU1nVOjKe9t
         I4nw==
X-Forwarded-Encrypted: i=1; AL+hErHuq7dAtom1OMwOzK7+WhnKrF/2pRJQf0+uxtY0seiei4G9MvLKIAgh/4YP7GV95Vgjzbth98lni/Ft1vMJ@vger.kernel.org
X-Gm-Message-State: APuU4Z9BJG6ko8tr8WdHOcFTL7rBZpmzfm26yQkePBaUkwuAPYtqSOQy
	7DH5KaLE8a4VEvuaWVWLgI7TxpVRn4FKV5HYdxm0nPoSsJbkL14lQ4EDDM8asJ5ruyKEuhdnpg=
	=
X-Received: from ejbgt15.prod.google.com ([2002:a17:906:f20f:b0:c2e:1bc5:6c6c])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:9fd0:b0:c50:a2f1:f200
 with SMTP id a640c23a62f3a-c513a5da8e7mr99034666b.16.1795115994327; Thu, 19
 Nov 2026 11:19:54 -0800 (PST)
Date: Thu, 19 Nov 2026 19:19:53 +0000
In-Reply-To: <av8QNiFcnGWocORy@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <av8QNiFcnGWocORy@kernel.org>
Message-ID: <av9L2ez51erKkQNo@google.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 19, 2026 at 05:05:26PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 19, 2026 at 10:42:05AM +0000, Hallgrimur H. Gunnarsson wrote:
> >  static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
> 
> I read the diff through but this led me to dead end. Cannot find this
> function from anywhere. I look the changes again once this is sorted
> out becaus this is interesting.
> 
> I wanted to look at the call site to understand how cap_bset gets set,
> which is not now possible but I do get the gist and agree with it.

Thanks for taking a look. The series is based on v7.4-rc1 and
set_cred_user_ns() lives in kernel/user_namespace.c, where it is called
from create_user_ns() and userns_install(). ns->cap_bset itself is
initialized in create_user_ns() right before calling set_cred_user_ns().

> I'd figure getting this relates to my rootns patches (perhas). One key
> mechanism for me resolving the unprivileged in my use case is
> MOVE_MOUNT_T_MNTNS [1], which is orthogonal but just pointing out
> the problem space.

From a quick look, they appear complementary. Being able to do more
setup operations from the outside generally aligns with bounding
capabilities inside the user namespace.

> I read through https://lwn.net/Articles/978846/ to understand the topic
> overall. Just mentionining as a possible addition to the cover letter
> (not a priority/necessity).

That LWN article is actually linked in the cover letter as [2].

> Hope these help and can be kept in the loop :-)

Will do, I'll keep you CC'd on future revisions.
