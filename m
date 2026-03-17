Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C62BCF5D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754824; cv=none; b=DP6LhRu8M1gTAFuy5EvI9tIg8QT89hjImPh0yp/zZtxYT5frA3oZZzlWtDZEyzIxihPL6gesTc3aboHMbVivUA22ks9CjyoFrzi77XJPfi8+B1RMxoNpx1+7vkzCzvsFe3qBnqUuYyWB6eHvVaHDox0PowQcfvo2jj/rlutnYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754824; c=relaxed/simple;
	bh=a2ZZfguIGGvdKDA8eFvOxG19G+zJW+npM8UJo/D6I0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DYVu5Jm328+ElyZ9F8nhpHQpddVh6ZnVzvOawq50+A/jck3IIqDNIxwJjOYnHsgyvqVaRyWYPlDV6soIbYoLYI2q0ZkAmQuBsro07TZqK2v7rI8Vp22GHoyIEsMYCsiNMIIk9q3/LEFCm21dV2WT/Ug80rsMRg0BVLGBxqGZt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujKAzrRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujKAzrRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C6DC4CEF7;
	Tue, 17 Mar 2026 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773754824;
	bh=a2ZZfguIGGvdKDA8eFvOxG19G+zJW+npM8UJo/D6I0M=;
	h=Date:From:To:Cc:Subject:From;
	b=ujKAzrRC8vEUP3A1Ji52Z3NUSvctBiFv5SK1v8D2Y249Nnn/LMSoEMWH2woYmMW5r
	 8yW+R52DUH9UkwHClwTA10+/C4s7RF1XN3oYwdMWPNTQzJh25L/2Lg1gy7iSx6tUsm
	 +k5LllBLtpyg3OZAba/EjL8lXQi4P/Ytey9Cm4/JxXSJqQ0t/2U58DCmEDNt23Oppp
	 EK7qCmIG/lbAzA2eU9medJIUy+2YAZ1PpiLRcxwQqvsIbE0oipGaDDibedqOk+M+RH
	 dq4SRf9SFFbWZYRIqef/WNyQAV0ytgsPHClHI4cyrID4YIGTUy819YB0cCqT/FJrzR
	 3q5smmNPgbDqQ==
Date: Tue, 17 Mar 2026 14:40:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Amir Goldstein <amir73il@gmail.com>
Subject: vfs continuous integration testing
Message-ID: <20260317-gezeter-mehreinnahmen-60da36d16b83@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi everyone,

I've set up automated CI testing for patches submitted to the VFS
subsystem via linux-fsdevel. This is modeled after the
kernel-patches/bpf CI infrastructure and runs vfs and filesystem
relevant kernel selftests against every patch series submitted to the
list.

So far I pulled Amir in. If you have interest in helping out here and
maintaining and have a longer-term stake in vfs related work jump on
board. I'm not a testing expert. My main demands were:

- No need for running yet another daemon just to sync stuff anywhere.

- No meaningful patchwork integration (no back-and-forth) other than
  pulling series down from it. Ultimately I'd like this to be based
  solely on lore and not on anything else.

The system has three main components:

1. Mailing list bridge (ml2pr)
   A scheduled job runs every 2 hours, discovers patch series from
   patchwork, applies them with b4 on top of the vfs.base branch, and
   creates pull requests on GitHub. Superseded series are automatically
   closed when a new version arrives, and merged series are detected via
   patch-id comparison and closed accordingly.

2. CI testing
   Every pull request triggers a build + test pipeline:

   - A Python matrix generator produces build configurations
     (currently x86_64 and aarch64 with GCC).

   - The kernel is built and selftests are cross-compiled for each
     architecture.

   - Build artifacts are packaged and distributed to parallel test
     jobs, each booting a QEMU VM via the vmtest tool and running
     one selftest collection.

   The following selftest collections are currently tested:

     mount, mount_setattr, filesystems (including all subtargets:
     binderfs, epoll, eventfd, fat, fuse, mount-notify, nsfs,
     open_tree_ns, overlayfs, statmount), fchmodat2, filelock,
     tmpfs, pidfd, pid_namespace, namespaces, cachestat

   aarch64 tests run under QEMU TCG emulation (no KVM) with a
   90-minute timeout to account for the slower execution.

3. Base branch sync
   An hourly job mirrors vfs.all, vfs.base, and vfs.fixes from
   kernel.org to GitHub and adds the CI workflow files on top. Pull
   request branches are created from these bases and inherit the CI
   configuration automatically.

Repository layout
=================

The CI lives in three repositories under the linux-fsdevel GitHub
organization:

  linux-fsdevel/vfs-test
    Workflow definitions, the matrix generator, kernel kconfig
    fragments, test denylists, and the ml2pr bridge script. This
    is the source of truth for all CI configuration.

  linux-fsdevel/vfs-ci
    Reusable composite GitHub Actions for building kernels, packaging
    artifacts, and running VM tests. Forked from libbpf/ci and adapted
    for VFS selftest workloads.

  linux-fsdevel/vfs
    Mirror of the VFS tree from kernel.org. Pull requests with CI
    results appear here.

The workflow structure follows the BPF CI's three-layer pattern:

  test.yml → kernel-build-test.yml → kernel-build.yml + kernel-test.yml

test.yml generates the build/test matrix dynamically, kernel-build-test.yml
orchestrates the build and fans out to per-target test jobs, and
kernel-test.yml boots a QEMU VM for each selftest collection.

What you'll see
===============

If you submit a patch series to linux-fsdevel a pull request will appear on:

  https://github.com/linux-fsdevel/vfs/pulls

CI results are visible directly on the pull request. Green checkmarks
mean all selftests passed; red X marks link to the failing test logs.


Limitations and future work
===========================

- The CI currently tests x86_64 natively and aarch64 under emulation.
  Native aarch64 testing with KVM would require self-hosted runners.
  Something to be added in the future.

- Some selftest targets (openat2, memfd, move_mount_set_group) are
  temporarily disabled due to build dependency or compatibility issues
  or they're plain broken...

- The kernel configuration is a ~700 line fragment rather than a
  minimal delta on top of defconfig. This may be slimmed down over
  time.

- The test matrix and denylist can be extended as we identify flaky
  tests or add new selftest collections.

Plans
=====

- Switch to mkosi-kernel for running tests.

- Add self-hosted runners if sponsored.

- Automated AI review.

- If things are stable enough automated replies on patches.

Christian
