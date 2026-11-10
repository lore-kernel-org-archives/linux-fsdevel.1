Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288706;
	b=UKV2neA34rdgOlPYnU8KYk9x8hRKIpynNQo0ZByfciqQyGGr/VKZG9Iky1c2/gOYWmb/
	 JZUURYg5e7pXjFGboVWBXliiJrHskiT9OaF8baDsvkUX1xfv2DvV9hLxk+QQsckDCvw1S
	 nWeguPAYEaHuKb4I1ahuPy7UPyXUJxIojlXVyajvOSNUw8Gurs8QMPxAYmjjfuFTUs0cm
	 q3mHbiuF/P/KGlsD1L7vR1OnQtQoxYe+5MWAYde2Mbu19HAXeV/2wuEunU8FcHfR2HwBO
	 db70D0uUj/LYdDN3jUuje1g+sKDMcZA+BDbdbwX7EdNxm3HNk1ZNaywxsSbl4qAmEzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288706;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v4N6CEsUv8RrVUeKKYOn2SlTG3d00sO7azLy5/TrcQ0=;
	b=unKgeHGi69a6y7ZrbFCCnzlUA/RGG/dC2mtTT4c/wh4Yni+lTkKmF8uAUlNiaprUtq5W
	 Og9bWsKmUyoibuAKv0jC41tL7jZMh9P+eOz0D9FtQi4HivWs7jL4ca6DVhqfwVDegBoCR
	 EgvgYNNBsj4W+q4Kb3Wj5FlH9ZRP8TjyL4n6ElXunyWSIx8zBfvDzfS1nilrfZgVc916D
	 8L9ZNjoYuySWt+JLatBpyXFPXcQatEAKyWejydbfnq4NMQ8aca3Yf1/VrzzJ4unHn8To7
	 nVnOO+05qqXVeVzhQLZVblA2XAcQy3CDi2xF7Ij86mF41n6Ai4afzH7lcsIfwJVc+aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loPadRfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF3606A325
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loPadRfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E251F008A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 05:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288705;
	bh=v4N6CEsUv8RrVUeKKYOn2SlTG3d00sO7azLy5/TrcQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=loPadRfdjOi8S1VAyFya2up5v9Qwgo3NrNbfFnzSpJGwHO6+00k31kXRHnBvW4i4b
	 csWZpo8GiRr8sBmXlThkF8aPEEVxwJWEO3eMjLRo7SHybFnbNFLwvGvkfBhc3taMMG
	 aiGV/cx5pCO8e3nnqLrsnq8fRqaz5oRAo1xzUP7l4mOOiymbMRZ5o/p4GabY037D69
	 7u3LLaBwraIYvoA69QxZEYJFcrf5xSyyEUNVw0aW+vPKl5JgXJLqkkSzIKfyi6G/wp
	 tgXb+zdU6hVR+e+Yq66ZZBmzgWnpEefYmBxSzFUweRGHv//dNvSdZGjahEUHieBHlx
	 h+xUddk5Y2yVA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d58c50743so52966766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 21:31:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH8rEWoYmHfK57rlaHBQqiZrFq6v0QBIOiAvvkwY/U13ECE6ppFU+qssCjeIH/xprCvdVaJiqhC1V5eOs70@vger.kernel.org
X-Gm-Message-State: APuU4Z+fDjCcj9xMu6i7Ioti78fsHU6iDXmj7eTOAtArLzwGV276ZgAO
	YG7ByomgDF72MbJFaxAPN/kRjDVTFJTwlGu7TjzqnGG1AHGWr1mh1cWSG+Q93luJrIHdEALh4vh
	5+eJXBC2pJqLkWr1RxN2gkccIcr7v6cM=
X-Received: by 2002:a17:907:e915:b0:c4d:456c:4a29 with SMTP id
 a640c23a62f3a-c5049582a21mr102830766b.14.1794288704427; Mon, 09 Nov 2026
 21:31:44 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793168155.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1793168155.git.jan.koester@tuxist.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Nov 2026 14:31:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-LSxEBXu2P6S1PGid2rzzWELcCncP02guz6zMGkZc5VQ@mail.gmail.com>
X-Gm-Features: AclHuK8YWklN2zsAN-HLO_wYWczPvjiJgKOTtoFW1cA9jTP6jMIMdI7Sxp3hAVs
Message-ID: <CAKYAXd-LSxEBXu2P6S1PGid2rzzWELcCncP02guz6zMGkZc5VQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] ksmbd: Windows SIDs for user and group ids
To: Jan Koester <jan.koester@tuxist.de>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, ChenXiaoSong <chenxiaosong@chenxiaosong.com>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:20=E2=80=AFPM Jan Koester <jan.koester@tuxist.de>=
 wrote:
>
> Hi,
Hi Jan,
>
> Windows names owners and ACL entries by SID; for a domain account that
> is its objectSid. ksmbd shows a file's owner, group and POSIX ACL
> entries as S-1-22 SIDs or as its server domain SID + uid, which a
> Windows client can't relate to the domain's accounts, and a SID a client
> sets for a domain account doesn't map back to an id at all. This series
> lets user space, which knows the directory, translate between ids and
> SIDs in both directions, for accounts that are logged in or not.
>
> It applies on top of the UUID/GUID id RFC (uid_r v2,
How is the uid_r RFC going? This series is based on it, so I would
like to know its current status and what you plan to do next with it.

> The user space side is sharedd (FenrirOS' ksmbd user space) with
> adconnect for the directory lookups. Tested in a VM against a directory
> server: owner and group of accounts that aren't logged in, ownership and
> group changes, DACL round trips, a session getting access only through
> a nested group, inherited CREATOR OWNER ACEs, and the directory going
> away (cached mappings stay, new ones fail cleanly).
>
> Questions:
> - Is a netlink round trip per uncached id acceptable here, or would you
>   rather have user space push the mappings of a session's ids at login
>   only? The latter can't cover owners that aren't logged in.
On-demand lookup on a cache miss looks right to me. ksmbd kernel
should cache the results as proposed and query userspace again only
when an entry expires or is not cached. Loading all mappings up front
does not scale well and is difficult to keep current.

> - compare_sids() matches a SID against any prefix of it; the token uses
>   an exact comparison. Should the existing callers move to that too?
Please don't change the existing callers. Some of them rely on prefix
matching on purpose. If exact comparison is needed, add an exact-match
helper and convert only the relevant callers.

Thanks.
