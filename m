Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2946D550;
	Fri, 14 Aug 2026 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713102; cv=none; b=e8EJn8+LpZDHRvXx1ZSBFboF5TH31DfanS8xSTzyCJR43ZALViDEBKnBXKPinIpgrlRZszkebpHOggMrEgsMdZ+h/zCb9HaYZ0TKDiK0pdiE2GTjQDLzb/2r5nSwUuTzTXaAVRZAuic8gkGSqVXTElN2zEXHNY/1Kyz4Ml3OeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713102; c=relaxed/simple;
	bh=oO8slQIMgEK8qcTdJZq0NAhAMcbB4UnQ+VafNxGr9FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHGADQ+Ue4dbdAdTCsUEaZ8C/k6e9UrktZcI4mmtAFyJkYoFdUAmeoOeOpznqVj1BzYbl5ty/LXcytL7IOJ7KvIXvABazEdKEpuX/Fmqd3kVIctOBOl2GjP88jRG1wNpRSj3uUj3E4b984nodYwxamJl5bmUg9xh5UovyQ/Zfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6pozBHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6pozBHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04371F000E9;
	Fri, 14 Aug 2026 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713096;
	bh=b/66yz/u9iqbcYU6ikh7xC/myWcSaPLKfkbLoib+VOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6pozBHa1HIF9x+pp0VOa5sR0eqkq0JGxLI+xQIVAR61OurkKpKW3a19yPgyOMbeF
	 uKVTEQ1gztIQNzEIHNquQbCU6W2twSUw66CNHBF9hMx7s0PuwX5bDtExsacCHQY3sH
	 vgHUqfgOhW/IiTZ9xxiCyb2/dKl+L7imNlmwN8XVt2TY+ddDvCbOSCp2h0iuRjCPIa
	 7bn6C7M942FCEyOlC13nVs4LvJ1FSzL1qt4h4N4zP2B3Go4RIPqYxbQGvh/HFzsi+4
	 1+AXjgunJHLuLgCjaO5AB5Za0rKPgDnFJq1jg1HGGQuarrUUuvSVrA6whxlN7323ft
	 0TM6klp1EEkMA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 03/18 for v7.3] vfs binfmt
Date: Fri, 14 Aug 2026 15:11:26 +0200
Message-ID: <20260814-vfs-7.3-rc1.binfmt-72f1306affcd@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12594; i=brauner@kernel.org; h=from:subject:message-id; bh=oO8slQIMgEK8qcTdJZq0NAhAMcbB4UnQ+VafNxGr9FM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVizDY1W689nX1fx4up9TARbz2Z2+KG33QY7c8W3ny0 l65NZGSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpLWBkmNQttsFzFr+l/c1z Ox+EBZ9+zZCkrHMnu3/1pPPrOtw2mTEynEr7o2ndfnjjCfW67e8Dr9ksTJ1w4f/R4urpc5hPzl7 zmAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a bunch of work for binfmt_misc. It fixes a bunch of old
bugs, reworks the locking, and then extends the format registry so a
binary type can be matched programmatically and its interpreter computed
per exec instead of being a fixed string recorded at registration time.

This allows nixos and other to e.g., implement relocatable binaries
meaning the interpreter/dynamic loader can be determined
programatically, say found relative to the binary. The mechanism is
flexible and can support other policies:

- Handler lookup is now an rcu walk. An exec that matches no binfmt_misc
  entry should now never writes to a shared cacheline.

- remove the VERBOSE_STATUS and USE_DEBUG compile time toggles

- convert the entry file to a seq_file which simplifies things quite a
  bit and kills a lot of custom logic

- make flags proper enums

- rename struct Node to binfmt_misc_entry

- allow entries to be removed with unlink(2)

- Add the ability to attach bpf programs to binfmt_misc entries so it's
  possible to dynamically choose the execution environment such as the
  loader or interpreter on a per binary basis.

  A handler is an instance of a binfmt_misc_ops struct_ops with a
  ->match() and a ->load() program. match() decides from the entry
  lookup walk whether the handler applies under the same
  registration-order. It can read file content as needed not only the
  prefetched 256 bytes in bprm->buf.

  load() then selects the interpreter and stages it through the new
  bpf_binprm_set_interp(), bpf_binprm_set_interp_arg() and
  bpf_binprm_set_flags() kfuncs.

  Handlers are published in a registry keyed by the registering task's
  user namespace and activated through the existing text interface with
  a new 'B' type carrying the handler name:

  echo ':origin:B::::nix:' > /proc/sys/fs/binfmt_misc/register

  The permission and namespacing model is unchanged. Activating a
  handler requires the same write access to an instance as any other
  registration. A container mounting its own instance escapes the host's
  entries exactly as before. The computed interpreter is opened with
  open_exec() under the caller's credentials and goes through full LSM
  vetting as the next binprm level. A program can only ever redirect the
  caller to something the caller could exec anyway.

- Two dispatch modes are added. So far the chosen interpreter owns the
  whole process identity (argv[0], /proc/pid/cmdline, /proc/self/exe 
  all name interpreter information). So relocatable find the dynamic
  linker instead. Also a binary passed to execveat() as an inaccessible
  O_CLOEXEC fd cannot run at all and gdb trips because AT_ENTRY and
  AT_PHDR do not match the exe file. So PIE symbols are unrelocated.

  This adds transparent dispatch which allows the interpreter to load
  the binary through AT_EXECFD and leaves the argument vector exactly as
  the caller built it and labels mm->exe_file and comm with the binary.
  It also raises the AT_FLAGS_TRANSPARENT_INTERP aux vector bit. The
  interpreter keeps control of mapping the binary.

  The second mode is loader substitution. This allows a binary to be
  executed natively and only the interpreter to be changed.

- Last, interpreters can be bound at registration time. Each interpreter
  is opened by its own write with the credentials the entry file was
  opened with. The program picks one per exec with
  bpf_binprm_select_interp(). Ucounts are used to properly account for
  pre-opened interpreters via
  /proc/sys/user/max_binfmt_misc_interpreters.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit b8206f516fe7cbe785cf44bf09c17c438d7c3cad:

  binfmt_misc: don't leak the user namespace when the mount fails (2026-07-28 15:51:25 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.binfmt

for you to fetch changes up to 68aabd01ddd26ced458a9e5716a640eaf8e4b7a6:

  Merge patch series "binfmt_misc: bound the interpreters an entry can pre-open" (2026-08-03 23:36:38 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.binfmt

Please consider pulling these changes from the signed vfs-7.3-rc1.binfmt tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (67):
      binfmt_misc: convert entry list to an hlist
      binfmt_misc: use RCU for the handler lookup
      binfmt_misc: annotate racy accesses to ->enabled
      binfmt_misc: turn the entry bit numbers into a proper enum
      binfmt_misc: turn the entry behavior flags into an enum
      binfmt_misc: rename Node to struct binfmt_misc_entry
      binfmt_misc: remove the VERBOSE_STATUS toggle
      binfmt_misc: use print_hex_dump_debug() for the register debug output
      binfmt_misc: convert the entry file to seq_file
      binfmt_misc: factor out the entry matching
      binfmt_misc: rename load_binfmt_misc() to current_binfmt_misc()
      binfmt_misc: return errors directly in load_misc_binary()
      binfmt_misc: give the parse_command() results names
      binfmt_misc: factor out the entry removal
      binfmt_misc: simplify check_special_flags()
      binfmt_misc: use a flexible array member for the register string
      binfmt_misc: split the field parsing out of create_entry()
      binfmt_misc: use __free(kfree) in bm_register_write()
      binfmt_misc: assorted small cleanups
      binfmt_misc: include what is used
      binfmt_misc: allow removing entries via unlink(2)
      Merge patch series "binfmt_misc: write access fixes, RCU handler lookup and cleanups"
      exec: stash bpf-selected interpreter state in struct linux_binprm
      binfmt_misc: add binfmt_misc_ops bpf struct_ops
      binfmt_misc: let the entry lookup walk sleep
      binfmt_misc: wire up bpf-backed 'B' entries
      bpf: allow fs kfuncs for binfmt_misc_ops programs
      binfmt_misc: let bpf handlers pass an argument to the interpreter
      binfmt_misc: let a bpf handler choose the invocation flags per exec
      Merge patch series "binfmt_misc: bpf-backed binary type handlers"
      binfmt_misc: require an absolute interpreter path with 'C'
      docs, binfmt_misc: keep general usage out of the handler sections
      binfmt_misc: table-drive the register string flags
      binfmt_misc: normalize the per-exec invocation flags
      binfmt_misc: split out entry_open_interpreter() and build_interp_argv()
      exec: release the replaced file with do_close_execat()
      selftests/exec: convert the binfmt_misc bpf test to the kselftest harness
      exec: add AT_FLAGS_TRANSPARENT_INTERP
      exec: label mm->exe_file with the binary for a transparent dispatch
      binfmt_misc: add transparent interpreter dispatch
      binfmt_misc: add a static transparent flag 'T'
      binfmt_misc: let a bpf handler run the interpreter transparently
      selftests/exec: test the transparent binfmt_misc mode
      binfmt_misc: document the transparent identity contract
      exec: carry a PT_INTERP substitute in struct linux_binprm
      binfmt_elf: consume a stashed PT_INTERP substitute
      binfmt_elf_fdpic: consume a stashed PT_INTERP substitute
      binfmt_misc: add the 'L' loader substitution flag
      binfmt_misc: let a bpf handler request loader substitution
      selftests/exec: test binfmt_misc loader substitution
      binfmt_misc: document loader substitution
      Merge patch series "binfmt_misc: transparent interpreters and PT_INTERP loader substitution"
      binfmt_misc: let a register string create an entry disabled
      selftests/exec: check that a binfmt_misc instance cannot be pinned
      selftests/exec: let binfmt_flag_supported() return a bool
      selftests/exec: test registering an entry disabled
      binfmt_misc: document registering an entry disabled
      selftests/exec: share the bpf handler preconditions
      binfmt_misc: carry pre-opened interpreters in struct binfmt_misc_interp
      binfmt_misc: let a 'B' entry bind its interpreters
      selftests/exec: test interpreters bound to a 'B' entry
      binfmt_misc: document interpreters bound by a 'B' entry
      Merge patch series "binfmt_misc: bind interpreters to a bpf-backed entry"
      binfmt_misc: correctly account pre-opened interpreters
      selftests/exec: test the pre-opened interpreter limit
      binfmt_misc: document the pre-opened interpreter limit
      Merge patch series "binfmt_misc: bound the interpreters an entry can pre-open"

Farid Zakaria (1):
      selftests/exec: add binfmt_misc bpf-backed handler test

 Documentation/admin-guide/binfmt-misc.rst          |  246 ++-
 fs/Kconfig.binfmt                                  |   14 +
 fs/Makefile                                        |    1 +
 fs/binfmt_elf.c                                    |   10 +-
 fs/binfmt_elf_fdpic.c                              |   11 +-
 fs/binfmt_misc.c                                   | 1618 ++++++++++++++------
 fs/binfmt_misc_bpf.c                               |  434 ++++++
 fs/bpf_fs_kfuncs.c                                 |   28 +-
 fs/exec.c                                          |   88 +-
 include/linux/binfmt_misc.h                        |  113 ++
 include/linux/binfmts.h                            |   40 +-
 include/linux/user_namespace.h                     |    3 +
 include/uapi/linux/binfmts.h                       |    7 +
 kernel/ucount.c                                    |    6 +
 kernel/user.c                                      |    4 +-
 tools/testing/selftests/exec/.gitignore            |   11 +
 tools/testing/selftests/exec/Makefile              |   93 ++
 tools/testing/selftests/exec/binfmt_bind_interp.c  |   14 +
 tools/testing/selftests/exec/binfmt_bpf_app.c      |   12 +
 tools/testing/selftests/exec/binfmt_bpf_interp.c   |   15 +
 .../testing/selftests/exec/binfmt_loader_payload.c |  146 ++
 tools/testing/selftests/exec/binfmt_misc_bpf.c     |  638 ++++++++
 tools/testing/selftests/exec/binfmt_misc_common.h  |  315 ++++
 .../testing/selftests/exec/binfmt_misc_disabled.c  |  172 +++
 .../selftests/exec/binfmt_misc_interplimit.c       |  232 +++
 tools/testing/selftests/exec/binfmt_misc_loader.c  |  372 +++++
 tools/testing/selftests/exec/binfmt_misc_selfpin.c |  158 ++
 .../selftests/exec/binfmt_misc_transparent.c       |   95 ++
 .../selftests/exec/binfmt_transparent_interp.c     |  112 ++
 tools/testing/selftests/exec/bpf_interp.bpf.c      |   61 +
 tools/testing/selftests/exec/config                |   10 +
 tools/testing/selftests/exec/interp_bind.bpf.c     |   76 +
 tools/testing/selftests/exec/loader.bpf.c          |   56 +
 tools/testing/selftests/exec/nix_origin.bpf.c      |  224 +++
 tools/testing/selftests/exec/transparent.bpf.c     |   57 +
 35 files changed, 4969 insertions(+), 523 deletions(-)
 create mode 100644 fs/binfmt_misc_bpf.c
 create mode 100644 include/linux/binfmt_misc.h
 create mode 100644 tools/testing/selftests/exec/binfmt_bind_interp.c
 create mode 100644 tools/testing/selftests/exec/binfmt_bpf_app.c
 create mode 100644 tools/testing/selftests/exec/binfmt_bpf_interp.c
 create mode 100644 tools/testing/selftests/exec/binfmt_loader_payload.c
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_bpf.c
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_common.h
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_disabled.c
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_interplimit.c
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_loader.c
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_selfpin.c
 create mode 100644 tools/testing/selftests/exec/binfmt_misc_transparent.c
 create mode 100644 tools/testing/selftests/exec/binfmt_transparent_interp.c
 create mode 100644 tools/testing/selftests/exec/bpf_interp.bpf.c
 create mode 100644 tools/testing/selftests/exec/interp_bind.bpf.c
 create mode 100644 tools/testing/selftests/exec/loader.bpf.c
 create mode 100644 tools/testing/selftests/exec/nix_origin.bpf.c
 create mode 100644 tools/testing/selftests/exec/transparent.bpf.c
