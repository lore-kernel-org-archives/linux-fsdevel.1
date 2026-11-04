Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793828895;
	b=XWQLKiEbY1YuP0SH31tKnW6778WrF1cs8npW2CNDQHw9Y0oZgBUJpSmVVGjxVzz1Ale1
	 Y7kbAac8inLET5el78Ch2BNIFX1h/JthdAE170hG1ODVTqqOutq2EfwFozQsstufLwhtH
	 omHGz99mrquwLOf5OO2HEm6YK3kAOR/UceWchVfci7zpTuyyaoaWvx43+vErn2z8xs98D
	 AxC31HXCVvEzYt11t6E4RTK2TROw5CWCWIJqSFzDavP3wx2nHIidQ+KOoagUAmBew/gOH
	 jbtPKM5hFWWrTW8airzK1FLWXTt5EzqAExbrzUpuxpZzG68lskF/G4wm1ULSE7ze58Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Oc6f/ASikXata5vUMYDvQklCjFtvL4sRQ4nqLiI8sWs=;
	b=sCHGA3Q4dyWkKWLmS/PkqkRMlAcsgbhZLXuV8Q0IPOMbpCo4G68fPNY/menrg1KwZFi/
	 MuNoH3E7t4Sgc63SRP0IdK1TRIP71YnuVmYWCUpCL6z8nmhfyXO3WCsbdFg0VEEp2kPbB
	 kwml3g+XjFzxfdapRrHch9uhNUe2TkS445iDAAvkAHICLb5SpUpXXjZP5Oe1LKTZwRwyL
	 TerdVEW4AuOv5luUzSrFhD894XaHJx5bUSY1UoAskAyokKucIMegEtmDaP6cFTIsKVVDV
	 o7xt9T3ezs4tWCkEY8yhRMRKdbiRu2OeSsIxiTb7JGU1cp36TK78/er5f7ULkEdP3og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ITK7JAL7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD3606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 21:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05CD3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ITK7JAL7
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so7655ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 13:48:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793828894; cv=none;
        d=google.com; s=arc-20260327;
        b=iDVF+/1PfVdxjRg3F497q/1WqRudc3sGDxZC4QO5LWErxphGtepQ53LTZHWjuh3VP9
         wo4IWzlwzW2onwa0zW82s0BqoMRYDKOb0Eunjrn2C4RC3tUYMRoRCuV/N/5hTPRB+tKq
         6UzchhzGCXtcXhokVd4cx9q6I+KJ0rQ0UaEhtU1vAYE8UKfangLLnzbTEUWLhmEubmj7
         lImFyNZxxWZuKWkM3GiWJbytRInxy830BZnicildSmd6n9kA49ty1INmzAqgZiww4mDg
         oqwnI3dLC6sKI7aWofr8LAlJ3CgTH233whvSagb+qE4Z0Lcg2Z2WLKh6A2UhmY2j7sfm
         /tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oc6f/ASikXata5vUMYDvQklCjFtvL4sRQ4nqLiI8sWs=;
        fh=7mJUVuDvnfYWIVRqWfdluoKVGa5gmjySN/dGUDufUu4=;
        b=fVSfUseiUhw5oaxijjLqmGckJOrU1AachmPrFd2XKp9REla4bImqWLJ24NUk8OYYT5
         7AjzOwnOkmbeBfLMgH4vBbLOzow7svbDCUscjAz+2g2DhQxSKngJqv9EOjP3V0OO54Pu
         V4VhM1lW/4Wva5Rc+cdU/RdGxsykJyAY0gezdphpNQE1nMcbjExmZAHL/13UOQLFSJG+
         hgch5vsXw6zSYW2Cn3UVdNdHkTtuq2KflBPwsvkb7dtGLJGdy6ongj3hsdM0aOymY1h1
         Tw/0rlHBKnU74A7ItbtE0YUCv/LBOJDO9cmWYrxXWLRhxJD/NqA1D6b2Bgxu7+roYcz3
         QI0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793828894; x=1794433694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oc6f/ASikXata5vUMYDvQklCjFtvL4sRQ4nqLiI8sWs=;
        b=ITK7JAL7y5jyONxon58r8tlFyklvy8ZUSX18aDBqA2v9j6NaYPS72EeSWbiWzzy3wo
         PpiMon9y9K8fiTWawMbEJvtCDUyyosKnFsxt+2/lgQY8uzDz0Bornlj0ToBuaayO/dts
         lo8/IM12Wj7wdqMy/n9+xB8KP+mOjyuEY5pRbbtoSGAyrZdq00MPaqaeN17MatXcX3uM
         6qG3fuWA3R2hnBuycoacmoQg78dsA5yj2/b8c4cbzoK+eUXf0j2cDcgOjz/BzOO8+dCq
         dVR339bBgQbZmcEQsUT0xebZBPeqSlrxLj9tCdK0SuHm40Wn0C9xkzkvbUj9zde1dY5s
         94fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828894; x=1794433694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oc6f/ASikXata5vUMYDvQklCjFtvL4sRQ4nqLiI8sWs=;
        b=x2GHj/G0JhHRDjl3DHhoB4lgyiMFzTqLKAElyJrklSySkDSpzLxM0JLq7v+5n1SSRH
         0nLkkulOPmRme7t9UbCZkg6mcK+/Y9GQWglhodszrwp7L2Uf46EOhZDAztN+ZViEaPeA
         wlIlU+V5KHqTj2pvMjYJCQ7r4yToCw3AMnSkWirgfeUIBGNNcOus30jsy44IijTiNkiF
         xeimyWnUafUs02rX/MdNHKIq08CeZbRwI4fmYHP9nKVNjoR4g+rNfYVV2Ctk4/KaUhOo
         b2TJrAiG5xswyjho9RXQmm3y4hc4ERJZa8pELynUDMyed9XDog1b0KQilSumbRxPs+lo
         itKQ==
X-Gm-Message-State: APuU4Z+Aq099JZdewomMd3NCo+WteKyRNYo6fcWfdxZ501wZ/0rSh3Mq
	x5axw91wXBCsroUCYduFxbsrRgwH6COSwbOMcVD90b/DR6Eal0OoJ8hp3lEUGe7QeGlHUtGXDnP
	H0zNNjd5xOF/R41KQkGcjiCx0Airf7jpI2TjzJXQL
X-Gm-Gg: AYBFou2lopXZ8fZe64lcZ/uJzjZzjK7aTfzrnovgD7QCBJVFADy486aRA1WevB73kra
	F3Pfu+hGcUjxiEs7E8nTd7o/xQsmdOXr6VFVodu7QiL2PDsRM/kYxxnQPjBvZH1BqRoLng48p5P
	Qa71g++fkS5a442Gd+/+xqvDVLOSVvXqkVfuDyBVUC5pwHfGwjzKS6KlvAJzFRdG0lwMj5MnG2H
	3jXc8LEoDe3HGNI5He177ToP3cGWYHxP9wrMkBCYTWe1yX2W9imTpO7xpWLYzb1fkNLgg2HkNVT
	m7pWa7ZBVC3k+RHXmbSuHBtv/+KVqYlslVD76sZt1B5lQgJwxYud4gVDeuNml8iJGmSnM7kOmdi
	WQ2ap8VHaqFGtHcQbHiOHaF4beIvAgC8xlLV6BrYVel+8GVzMXdiFtOOl/HEjq6L7zZx0yiTyN+
	BuD2x24tiYojhEeMA2RPRv1IFEXVEMG2/uPnGT2Ns5YzkJ
X-Received: by 2002:a17:903:1b65:b0:2e6:12af:5b04 with SMTP id
 d9443c01a7336-2ed25660db5mr1651045ad.0.1793828893442; Wed, 04 Nov 2026
 13:48:13 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org> <20261030-work-procfs-ai-fixes-v1-4-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-4-772392d3ccfd@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 22:47:36 +0100
X-Gm-Features: AclHuK_YfYoNc5s7KPT6b-OLPNNNi-qC_RgHT3YEOfIm3yKfhFmrD2A6AzFlGwI
Message-ID: <CAG48ez3vuVnv-CYfoOipS+oXVLyVVvX8F8DA7vJC8vvWkUAu2A@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: stop the ksm files at a privileged execve()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> /proc/<pid>/ksm_merging_pages and /proc/<pid>/ksm_stat can only be
> opened by the owner of the task but they show the mm the task has at the
> time of the read. So a file that was opened while the task ran as its
> opener keeps working after it executed a set-user-ID program.
>
> PR_SET_MEMORY_MERGE survives execve(). So the opener can have the
> memory of the privileged program merged and find out how many of its
> pages were merged with pages of known content, which is what the mode of
> these files is supposed to prevent.

(Side comment: An attacker process can probably get somewhat similarly
useful information by monitoring what pages in its _own_ process have
been merged... PR_SET_MEMORY_MERGE seems like a terrible knob, maybe
it could be made less dangerous by clearing this state on execve()
with ->secureexec set...)

> Use the exec id helpers and hold exec_update_lock until the mm has been
> looked up. The files need their own file operations for that so the
> exec id can live in ->private. Reading a file that was opened before an
> execve() now fails with -EACCES if its opener has no access to the new
> program.
>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
> Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each proces=
s")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
