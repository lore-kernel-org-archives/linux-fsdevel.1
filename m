Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696B31F9BA;
	Mon,  6 Jul 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353686; cv=none; b=t/MXksuE5yuf9SdPHRBRflGpFbfSgo1Swn0NWiI+w07ElTXGLbO1Qse+Ob4mykMAlhc2T9yI6iX9Dq9Ym595VyYte+uF+m7rzFwj51OX6mRZFMwK/oaXyfUxSPvsPQ1IjvL5IASPyY8zJKWQa7HJQsT0Zl47ha9OTodsy3Fn6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353686; c=relaxed/simple;
	bh=vCKa3tHYjrHa3FtjHkl8GSix2F/vIqRMdeiR5urB4iY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hI0otXHOKzG/iVi0RUh7CDC3CE64O/Chx7ORH+9k+q9rWxzrRTLPq2LEd1CCSfD45c6FVEIAhOL13pkpsaJnD4RtXYyBglHYZcw8bERUilzdaPCKnwaU7qveIAJGpGC/D7PKWFKHKevIjwmEBBrPUL0BvnlNv28tghcaXZTG3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okefVVjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okefVVjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E671F000E9;
	Mon,  6 Jul 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783353685;
	bh=zIjsvZIGtDb45yOCtzuITMhCZIXsn/rA4+SmB8HdYiE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=okefVVjPOvMtHSgZqi2LcJfAfJkW74KQqZku3zSnBXSyjlCmqe9KJoEheA1JNDmWa
	 kQ0jbGkAdaakorgQF1UuIQyCN0/dt95BjlXgTJyQZk792sDw6TIAgBlITpL3P/aZc2
	 sSAy2ylA+7R80ZTW7k8GNzAtWFXjj22FDWktB/TgoYVOeXiScTv2Lg7/+NbDK+j3H/
	 QsZXlB569wdyYIOy7CXF+3jfqmqXhmtWlonHwz63z/DNFy2xO04JEkwkJ/fV2tPXjk
	 4E09L/U4YOhPiSOg+iETgj2CXxZyygHAgfn5VARj2dix+DJkKJhR7yskyg1yrh7U6v
	 muMvUHAqXU54A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: brauner@kernel.org, david.laight.linux@gmail.com, jack@suse.cz, 
 jannh@google.com, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, mail@johnericson.me, shuah@kernel.org, 
 viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
In-Reply-To: <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
Date: Mon, 06 Jul 2026 18:01:19 +0200
Message-Id: <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vCKa3tHYjrHa3FtjHkl8GSix2F/vIqRMdeiR5urB4iY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5XwxStPp6qOYYR5k0Iytj7zmukvqTzkzVBhPVDDPXX
 7hl95Sxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKfVjD84WuOE9jCfejZzJNC
 LZ7JfKdd23v/b1lxJVdS+52jyh5OPUaGe+yr2ft+SZgxavO2Nb3jbS3WTLe+nWA5q+rtbaNfdZG
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Historically binfmt_misc has only matched binaries by magic bytes or file
> extension, and always redirects a match to a fixed interpreter recorded in
> the registration. This is insufficient when the match requires parsing the
> binary header (e.g. inspecting ELF program headers) or when the interpreter
> must be computed per-binary rather than hard-coded.
> 
> Introduce a new 'B' (BPF) handler type. A pinned SOCKET_FILTER program is
> registered in place of the magic/mask, and no interpreter is recorded:
> 
>   echo ':name:B:<bpf_pinned_path>::::<flags>' \
>       > /proc/sys/fs/binfmt_misc/register
> 
> When a binary is executed, binfmt_misc runs the program with the
> BINPRM_BUF_SIZE file-header buffer as context. Returning 1 selects the
> handler; returning 0 falls through to the remaining handlers.
> 
> Unlike magic/extension handlers, a 'B' handler carries no interpreter of its
> own: the program chooses it via a new helper, bpf_binprm_set_interp(). This
> lets the program compute the interpreter path however it sees fit (for example
> relative to the binary). A 'B' handler is therefore a strict superset of the
> existing magic handlers -- any of them can be expressed as a program that
> matches on the header and sets a fixed interpreter.
> 
> bpf_binprm_set_interp() is exposed to SOCKET_FILTER programs and stashes the
> chosen path on a per-CPU area that binfmt_misc reads back immediately after
> the run under migrate_disable(); only a match that set an interpreter
> allocates.
> 
> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>

Ignoring the blatant bpf abuse here I think this is quite workable. So
this can be turned into an actual design and patch imho...

Note that binfmt_misc is namespaced and can be mounted inside of user
namespace + mount namespaces fwiw. So a container mounting binfmt_misc
(a fresh instance - few do) would escape that bpf program. On the other
hand it would allow to register a custom bpf program per container if
needed...

-- 
Christian Brauner <brauner@kernel.org>
