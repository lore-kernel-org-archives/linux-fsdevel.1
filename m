Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C2264FBD;
	Tue,  7 Jul 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424092; cv=none; b=eEEStXzlhuUynMEwVfbk7hKPyqCpLJjATHFHMyKzDH4OzOp8xuiMqY0Cl8cIzpNZis3uTi/N67spt5gSP8Ig5mO5XlxwNe0etEMYJ7XenLZdA5bXrrluWb0kwgvyJ44swY5O8T062qWONTSfjA9cuvLQzVgVk2nEXuwj5x/YgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424092; c=relaxed/simple;
	bh=zBPUW+WQ/GjuRupYdwz/7FHmp89KGxrLyUS9t0y2NyU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=si+YwiR8P42BiX8Fa9XFtIneVgTbq3tdEWjrbRnlUJKmt+03BN81b0F2DlLsmwbQn9bFLzIVQ7rJVcnnnvUFQiLjvx6Zt8WVOerdIp0fcs/6ckpCp0M1HzFYAX+oG3iCCcsq+6CPeSiZvrPmcN1ZyF0P3DmCZrRVoqxn79A5yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxElatQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxElatQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386571F000E9;
	Tue,  7 Jul 2026 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783424090;
	bh=xD7a/PykFMk76eX8/Vohs5LQ/Ovej1+QHxfa9aUv6iI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KxElatQYxv1NDV7ZRp28MI4mwxdFDntYF6Wepqb+KQ0fCpXULtGhYLd1ZwhCpwE5t
	 smUsPY7tDXC1bPg67nofX7s8Zo74QTynRz1eShZn35qt2duFR5eYxL6JmgjGjMtXhv
	 zsMPeiuJAJi1POB0mFeQRQynkJe56KdkvaxghcaRLcFsNZOHNBnnXqmO+380NF0w0z
	 MlrXBWM5TER/rH5e6S4PzGWlxXoSKiQnmgXK3blzKFGetTn5VZlGGnH0Pn7GRKNSOk
	 Dxpmkz2e1ZSjzv43OudYSdCbrS5nXC1YDfyJVuKikpnW7HN1XZIx/uCusz4ZEFkQzD
	 boLajUpNZhiiw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, david.laight.linux@gmail.com, 
 jack@suse.cz, jannh@google.com, kees@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
 shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
In-Reply-To: <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
Date: Tue, 07 Jul 2026 13:34:46 +0200
Message-Id: <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zBPUW+WQ/GjuRupYdwz/7FHmp89KGxrLyUS9t0y2NyU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5PAm/Ib/tm2Wn+4vyDv75We5Ws38unHZes8Mkw9zG6
 JnkzP62jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8/cnIcGRNwrINtdMr/8eX
 hyzkbDET+dxxbnX9Zz5vrp1LRfL2rWT4Z7Dz3jdV9ijN8xOEfghc5k3QOpNw8bz073THWa7T38i
 asgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
> On Mon, Jul 6, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> 
> > Ignoring the blatant bpf abuse here I think this is quite workable. So
> > this can be turned into an actual design and patch imho...
> 
> Glad to see you think this proposal is in the right direction.
> Just for my edification, when you say "balatant bpf abuse", you mean
> how it abuses the socket bpf type?
> If so, do you have any guidance on a new type or should I just take a
> stab at it.
> 
> For the proper RFC patch unbastardized with tests, should I start a
> new thread or is
> the convention to keep attaching it to this same thread?

Always start a new thread and bump the version number. So we're at v3
now, if I'm counting correctly.

Fwiw, if you have access to an LLM you can try and setup b4 to manage
patch series. It's quite easy once you get the hang of it.

> > Note that binfmt_misc is namespaced and can be mounted inside of user
> > namespace + mount namespaces fwiw. So a container mounting binfmt_misc
> > (a fresh instance - few do) would escape that bpf program. On the other
> > hand it would allow to register a custom bpf program per container if
> > needed...
> 
> That makes sense -- but you will need CAP_BPF etc.. to load the new
> programs though
> if inside a userns.

Right, bpf tokens exist to delegate bpf access to containers. Not always
ideal but it works for such cases. My main point was to communicate that
containers are able to disconnect themselves from being able to execute
binaries by mounting an empty binfmt_misc instance, iirc. I should
remember that as I did that work but I kinda don't exactly. :)

In any case, I think it wouldn't be crazy to allow registering "default"
handlers that appear in all binfmt_misc instances if needed so
containers with separate binfmt_misc always have the bpf program
available. Just thinking out loud...


