Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849543E07B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850952; cv=none; b=mwp3HxpyOyLdd4Ly+zM/fxryu/tIVWnPgs3ulk4g+4gbzQ3ZttmEUD4Xs0PJLmjri9tysh5KaWaF33Fpcb2Me3HBSKTY23LC6Ce7yHmE5Pul1DCwJLkPqBhYUpX4OXrRaPredQPb7hh6fJQwhcuvKksHrx1mJr2JbhgN3Mzch60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850952; c=relaxed/simple;
	bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3/L89n0lUhKGnC3WpdX05qABHxkmpfk7RAMiVpXK8PhZ54kqz+Sm33o9wmMryXgmD+nGaqKOOZ8ruo+EkcqK+gIKZpf0k0B+IDntilpkbcfWBlWhskkBh6Bd/rpIznzZFPYHW1vnNDH2qBfNuWRT+1I76j7QJF/R+Grj6/gYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HVNDJ2sl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HVNDJ2sl"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e27035206so4714841b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785850950; x=1786455750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
        b=HVNDJ2slChBLAnAtHJWsuM0GqQ+U+3j5u8Cc8lkAul0O+w064O3addkYOLXF8JgZA5
         JVvXgnopt/Ar23f/ERGQYebRecvOLu1bnMh/KasRc4bAUdtPyEymba/0tQk3od0O1/n1
         seakULTsJyWKgcz8t2Th3LZwg9ADI7IyEVMSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850950; x=1786455750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6BqqmJ+CkjzQyLJ9nl1mxgsYp2XZlncwLWU2u6v8GGk=;
        b=hhFpHwC4p+aRweg3wkclAOV6fZTzxqF2rRMdWZWfRViiwx9NFZ9y1Bp7dmI1BBXBOl
         xMZq3MKDZsJ/WQsTuzuVadUJ17o6guv4RaEtVoFY+7N5ML+JIh6etL0CBgpo99PTGXWl
         LS6bEXjRCGf815XNQKMeg24nkBQ4vxzlUOBtr6qXjqOT/sBdOhMVaFISIvAJJ8+UVp67
         scLBsjwJpzh4RO+hYig9muI+GPOQ3I1FGe2Rul7TPUg30qzDzUOYLW1an3s1FceFnpd0
         +t/X02j0h7dvhsy0JN7VbE3PrmXuUDmDtX98H9abzoerJbT0tL1LSvblnANCud8XHd16
         5L2g==
X-Forwarded-Encrypted: i=1; AHgh+RqY6DmABjS83V+S9IofPuhJbxoHg3m7GytWVi6hOCFqvDfJ/2IpJE6g4DkiWhABSIAdoVZRV5KAIlkrsm2f@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1fVVOzJTaRm86HHjD1G2RMrtiO7kgNw1QpnF9as5j1yCuI5k
	T8MZ4jHvQu77l5NZ0Vryyov4i/dRoo9RrDvQsjE6H3x/txef8FzDl8rJQMilsBHsCA8=
X-Gm-Gg: AR+sD10qsYRCyUDUygto3b11O90dGtCnTjSjoFkokXmR+vDe9SBtSoinaynUAfDcDbj
	9HtMEIvFjO4xg5OCMj275OoPFSuekO76tyKQB23N9xLCMh2zIQq6JV4J6jgD0lR+AiLbDYT0yjO
	6QrPhsey84eE48KLIrW0hsdPgC0v30Znj2tEMfzBCFxnja0Wzy0gHu1sItXhz4Nv1ILmMqP2knz
	UJW7674CuH6IBAqirzcnjKLzifwoPJ8jJ8NcYCQde0cI++zlnySi2mTqopxpnkX8NQZ52D/1dYU
	DjVVE+xnXM9FngPVfHGKs6HEmHyDOzkfGuf5oKM5CqStpRQkNBQBM27e2CUwLJAaj8bNxuLA6aj
	48SeRw7uNKkpumkL9A9/p9qH0yNSZ4wXMVOgW03tSK9r7f9mdHWnSg3py7BqrXWPF2AEdEgscFo
	goRYwyE/Mt6rgskYeHdBkXfb4F+IgPt0jZ8UTe9x4etQp180eAhIA=
X-Received: by 2002:a05:6a00:12c9:b0:848:67ca:c03 with SMTP id d2e1a72fcca58-84ee4915d1fmr13645029b3a.58.1785850950265;
        Tue, 04 Aug 2026 06:42:30 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:e3e3:8255:fe3e:c7f5])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm5258690b3a.39.2026.08.04.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:42:29 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: jkoolstra@xs4all.nl
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	farid.m.zakaria@gmail.com,
	jack@suse.cz,
	jannh@google.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	mail@johnericson.me,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Date: Tue,  4 Aug 2026 22:42:25 +0900
Message-ID: <20260804134225.3631912-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <al_MqBrjDW1QjRau@daedalus>
References: <al_MqBrjDW1QjRau@daedalus>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry if I messed this up. First time replying via git.

>Afaict, currently read_code() may blow past what vm_mmap() allocated
>there, which may result in memory corruption for a non MMU system.

I ran Fable on all of the "nommu files" and it found the issue this
commit fixes and the above issue,
I sent a patch (co-written with fable) and we proved this is an actual
issue on nommu via a reproducer tested on a real system.

https://lore.kernel.org/all/20260710121443.1059549-1-daniel@thingy.jp/

Thanks,

Daniel
