Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18C185B48;
	Wed, 14 Oct 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018700; cv=none; b=gsw4XByXLAVZOv0B4dOk+g/cQykEFAU8sVYaKqgkgxaAKBkXybEL5dh9j8HKvwDMBTew/kB1/fBdh9GJr16jtqezkvgvotDJLAPhjyVceJ9kpWWx4xwTbx7Vv28SoghrVK68OKqzQa8NZMYtDw7weIVfhQbm7StxYnJYEYFVnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018700; c=relaxed/simple;
	bh=a8GyNuOkJam97IF5PUJ8I6Q97oi1RXSNrJomIAT/JnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gt+WbF5bO3E1cU71Ifuh5puMnHD2wftYspgXptvagDMcjyAaYXli7CsetBs7I8u5W4rJjhTBnFKFJaYsGxG5Q2zg8x6RskTf9CXKryvGZ/ouC2nKTUfJ29q262MJTzBMu0AqHda/W6zaFaG/7MKxPy4Un9qZzvi1gVAx6NekyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCR6mqrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCR6mqrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2A61F000C4;
	Wed, 14 Oct 2026 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792018699;
	bh=hYVhfY5F8PE1JdDUkR9iDsmlsX80vTZYlpXji/UM5Is=;
	h=From:To:Cc:Subject:Date;
	b=oCR6mqrkvg9tvUzPi0tmh97KemdR7KpFN8T2OqyFwlz8GVHqveIou13XgfmXmC1wQ
	 J0MnsDdH1FMnLhnQZaWg1kx+cMkyMa6zNKyeXJItJYdfLe8gOfku6bo4nFJp0kwIKH
	 tApGjiZJ3SOslF6c/3r5W/UOxj0FUQeEbNq2j8Ezy4UM8zd1jrSBx5Yj1XusmBDsWp
	 7d9AJi2aD8nRD6/bA760nbPwnqz+j989NeXontesLAADAetTvxJp8hFlDxcujuw6cC
	 XQJIFTOX79LCjhyoUauiO2vkbXrPg2g0OXt3wg1slrASNEfzimdIJvD1L4fx3QmtH6
	 GmQP8F37/sNeQ==
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Ian Rogers <irogers@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	llvm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] Add __require_explicit_initialization and its first user
Date: Wed, 14 Oct 2026 15:58:14 -0700
Message-ID: <20261014225811.i.852-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=kees@kernel.org; h=from:subject:message-id; bh=a8GyNuOkJam97IF5PUJ8I6Q97oi1RXSNrJomIAT/JnY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkXONkbbz2KnNUTIdPJomgRGFTn3FW865j2uy3FisbKe 3qnXPfsKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMjrjQz/FPYp8H5YXhzPbPFN YmXFa76V/LmKrJ2qha4BD9In1CunMDL8Xc0TH77uneL5VY+lvBsWNE/e+9gwUHTfk2DNibMNJr1 kAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi!

As discussed in Ian's kobj_type::release series[1], this takes its first
patch (to add __require_explicit_initialization), with Miguel's requested
comment tweak (the attribute needs Clang 20 or later), along with a first
user that needs no fix-ups first: seq_file's seq_operations callbacks,
which are called without a NULL check. This will make the attribute
available in v7.4-rc1, while the kobj_type fixes continue separately.

The annotation adds no warnings anywhere in the tree today that I could
find across allmodconfig builds:

  Clang 24.0.0git: x86_64, arm64, i386, arm, riscv, s390, loongarch, powerpc.
  GCC 16.2.0: x86_64, arm64, i386, arm, riscv, s390, m68k, mips, parisc,
	      sparc, loongarch, xtensa, arc, and openrisc.

Thanks!

-Kees

[1] https://lore.kernel.org/all/20261013223946.1836757-1-irogers@google.com/

Ian Rogers (1):
  Compiler Attributes: Add __require_explicit_initialization macro

Kees Cook (1):
  seq_file: Require explicit initialization of struct seq_operations

 scripts/checkpatch.pl                 |  1 +
 Documentation/conf.py                 |  1 +
 include/linux/compiler_attributes.h   | 12 ++++++++++++
 include/linux/seq_file.h              | 13 +++++++++----
 tools/lib/python/kdoc/xforms_lists.py |  1 +
 5 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.55.0

