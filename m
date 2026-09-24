Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A03D1CA5
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216459; cv=none; b=FOXd9e1kbEqRstQGBOlZKq8kAdvowZueBgMlExtYNTgfuEKYqkB5Y2x//DHlm5SaNNj+7XxzdgIWbxeOM5NkZYPdNNDKAUxkaJ1+7TVmwDhqUfTOlkaHOAJppgWeVnHR/8mAN4agQhcju/kn1fhqoSHjxJyf7ywvBmbOviUApxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216459; c=relaxed/simple;
	bh=lcL5Eetl3nG3gsUqwm83uBVrTGBkvNDFKF7rcFmnNeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TQx4nrXRrscy6JF8lT9oLGtsFDghHQVfL4ysS3CyGB3IWP7KGutZeKF543FDrvEULnVVkkP8OoCyIPvG2q3ZkFZnLNWfDDXBKR0C0P3G9+bYe9R+FcnJPdJIO+mGiSJssRHIuGFLoUp6gmbp7Jy34u809iASilhQFIQso6SXZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCZ2Yfmk; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCZ2Yfmk"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so925930a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790216457; x=1790821257; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1OywjhLcf7AEhGOTuREC2CMLevxoLPp6meiFe7hYNSE=;
        b=eCZ2YfmkNf4A0dspZwt92Q8K5g21yl9N5y1EctpberS/8Ha4zbwyMdbiYDNf8ezbf1
         NVX6fzPU1cQiMyK+pg+y3zYWgbAC7LdVqeF5IpYtZj7vKWU7jCnGj/ZG5fSNtv3aQlaT
         eGl29sjcNiOVzPYyMflrnEdaN3XNN5PR19cHaCi+V1sTv+mvS8GvPH+FkVayHNGMltnq
         S4iTuECHrKa6vcjr7807YYE0a4RN+BXYNsPIOg5ZKqEXI2IGLwIlhOZaghiJtyGgeDrz
         ZgSKKFbCm73sITZzz/ed/IG+y92/4YRlaRd90zKvbGt6guXwhvQkFNozEpUA91LXpG0l
         Ehug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790216457; x=1790821257;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OywjhLcf7AEhGOTuREC2CMLevxoLPp6meiFe7hYNSE=;
        b=HJwjWkniNaW3Sm0nQw1GyeIxP6knZm+Fp879F6xbGUMZwwvBgN0sO6/14tr9dy+cu9
         3UwS3No+5vh6sGBvcE1sTK/JT69IyOqEgl0bdDB6odp5aLZOFfI07grHvH2w30y3olZm
         9cx17Sm0Mps0fBNHp6+2U4wVi0SRoZlSYQIs/Uyh/0S+XMI+ypr9gMhV05MaJKendcka
         9nGo1JNe+r1SH/kUFXiNQT+OFbDaG/DOj67TBoJxiNFiJI+GgRLEu8ZJ2naNNVNrJmmG
         qaJ6WLO4EP8BKplS0dnTBX5zwGWa0LQnsad1pMmQnPUbw9u+g9P5jrl7vBLs+nb0SSXF
         TSmw==
X-Gm-Message-State: AFuF++msxZU+qjmKI6YyHqZvb2Gi76zTogvmyJRZrvgvjjLYwrmzMw9k
	PX+FfLTcaO/ddbVilStZ9FApIi+XOVex/Q9gKxDthjHAxNUkFeYgJqUg
X-Gm-Gg: AYBFou1clWWuCIQQs+uvT/qFYQlPFnFLohAEb53+Z1BEku6Y3DawWm7cUWwOhiZPcaH
	11c9sljoEIqLT0znvRRzH7HnrNXWLoyPEjWHFzMvUPw/kOIKrHHIfxCys4p3zUtlopmw2eOAw9r
	YJ8aLj/gqPNCupKjX/lLgev85IqwcZhly8glb0r6GuwKEbeJLft6qeO90L5LD0gvvqnK5TRIQUk
	bFptkzJxKOilXFSxMDdSDQOCLdSR+0y8lcybNYlw7sM25G26rVv/A7SbsaDFi0x3LLsIsEMTtjg
	Eh0GmciFbsaQu4P0yHMhsAAGIAnaQqIYBcmgJtPMVlHUSEnQT477kyNcqYPnhBxxi/t1nigVdKT
	XyiMn44izr5pB8eFqqOsQRrpafpM7tMMLfs/4rfSwBwhTsv9f0di61kSWuck5iR5iJl72hFKx59
	B71Hyu0wc7bM7iIASDz0xXYlfuBNWWVfv1NNCFA6n/mTqXDNWN7x19yrUMrlhT6fXCpkVZm83Ak
	Msba4zR25mFSHW7B75uCuFAjAFF9ABr6WQKbeu50gNTh4HAE4brl+RkJsnHKiU6E0Sifwtc/hBW
	ukBwvMX1BPk0MQ==
X-Received: by 2002:a17:90b:540e:b0:39e:6a7e:ee1a with SMTP id 98e67ed59e1d1-3a098da41a6mr835896a91.38.1790216455439;
        Wed, 23 Sep 2026 19:20:55 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a082872cfasm2420945a91.2.2026.09.23.19.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:20:54 +0000
Message-Id: <DLN6RPOBSYOQ.13B97Z6OSFXY5@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in
 path_unlink/path_rmdir
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Parri" <parri.andrea@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Alexei Starovoitov" <ast@kernel.org>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "Song Liu" <song@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260922145530.369775-1-parri.andrea@gmail.com>
In-Reply-To: <20260922145530.369775-1-parri.andrea@gmail.com>

On Tue Sep 22, 2026 at 2:55 PM UTC, Andrea Parri wrote:
> bpf_lsm_has_d_inode_locked() makes the verifier rewrite
> bpf_[set|remove]_dentry_xattr() to the _locked variants, which assume
> that the caller already holds the inode's i_rwsem.  The path_unlink and
> path_rmdir hooks are listed, but security_path_unlink() and
> security_path_rmdir() run before vfs_unlink()/vfs_rmdir() take the
> victim inode's i_rwsem, so a sleepable BPF LSM program attached to
> either hook mutates the victim's xattrs without the lock held.
>
> Drop the two path hooks from d_inode_locked_hooks so that the verifier
> keeps the locking bpf_[set|remove]_dentry_xattr() variants, which take
> the lock themselves.
>
> Fixes: 56467292794b8 ("bpf: fs/xattr: Add BPF kfuncs to set and remove xa=
ttrs")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 6cb8772679782..357a379ef92a5 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -472,10 +472,6 @@ BTF_ID(func, bpf_lsm_inode_rmdir)
>  BTF_ID(func, bpf_lsm_inode_setattr)
>  BTF_ID(func, bpf_lsm_inode_setxattr)
>  BTF_ID(func, bpf_lsm_inode_unlink)
> -#ifdef CONFIG_SECURITY_PATH
> -BTF_ID(func, bpf_lsm_path_unlink)
> -BTF_ID(func, bpf_lsm_path_rmdir)
> -#endif /* CONFIG_SECURITY_PATH */
>  BTF_SET_END(d_inode_locked_hooks)

Christian,
this looks correct. Want to take it via vfs?

