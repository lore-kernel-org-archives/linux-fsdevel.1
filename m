Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0832ED39;
	Fri, 19 Jun 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858215; cv=none; b=rr/JBc4WMw6F+w0edKc92aVG47B0y/A3sfIJE7P+m4yZ+Y7txUY/+jrJbVMye8MVn56o5tXgW6OryYjMlVeDZb6sHi6n8o960VgpABPcWvxvjYq5Uq1FcX6d6vRkly+duJ8wJ76UBpWOw/1V8LoIASSb25axObe3hZjADCX/4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858215; c=relaxed/simple;
	bh=4WnUnn5+hWO+h3ivDAtlJLmFZkMrglyzFTY+tJ7QgjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fn8BcY0qFzOdYRK+V6WC2gXlxqg2j2XLRBpbZeSWUE7xueKya+Gl1K0OalKgG2n9tyZoGnc7+gvx6gfoMdttNG7Gv3I/77c1c0NC7kdDDlPskO3RnSCblVlgUdShv8ITu5NcdlTi+OvzKQndehGv+pL8iFAJpDreEDmUl5UvkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPpxFmfu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPpxFmfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C036D1F000E9;
	Fri, 19 Jun 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858214;
	bh=+0xWRA8LZGr8NhjjDPmMP9Km9GlqhdcfCG+GwkZQaC4=;
	h=From:Subject:Date:To:Cc;
	b=jPpxFmfuTd1UzQ1dicUHNhpFC/9WvA5mKW92jWWhrVXDPT9fwP/qZHiOaPY56CznG
	 nNMU6uKpyAQnkiMLY3PkWPjhhLJUl61lbxkvL508xibuBNGSQYG6u1DPK+Q10RvA6i
	 x8JsHHE3ncpNcZ9AVV2UCLk6paq5I8mjC9pT1rlRS34M2tSSeX1Mo2BYjPodiJj/kS
	 FPxnhADy5/dwvgPWZE+T2EmmwrggdeQlkzhFrZzsqHvVGG5KVmx1tF8lUvKqKS93K6
	 fPP2ySqL8z8G3yJevaIs7EGXjpaV9ELK8iQZTkpM6iiLWKzuCY61AxNkYZuCHRPAs+
	 ofLqHL3uxoimQ==
From: hare@kernel.org
Subject: [PATCH RFC v2 00/12] namespace-aware configfs
Date: Fri, 19 Jun 2026 10:36:40 +0200
Message-Id: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJn/NGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0NL3eT8vLTM9LRi3bxi3SRTcxOLJGMzMyBSAuooKEpNy6wAmxatFOT
 mrBRbWwsAzOH4tWIAAAA=
X-Change-ID: 20260619-configfs-ns-b5748b366366
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=3515;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=4WnUnn5+hWO+h3ivDAtlJLmFZkMrglyzFTY+tJ7QgjY=;
 b=eRD9VDey/sZ2GUJ8NW92l2ZbbNrykTYDvxkRhsLeZUSvi9fa68w/2ff+Hjo+5U4DcpGvD74j1
 FTJikKgJWD7DzDXI57EAEJSObMt1ASwB46WEk8YywRVJlwGD95/Q3Of
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Hey all,

during discussions at LSF/MM I thought it would be quite helpful
to make configfs namespace aware, such that one could do:

unshare --mnt
mount -t configfs none /sys/kernel/config

and get a new instance of configfs. This will allow to have distinct
configurations for each namespace.
This is particularly helpful if you want to run eg nvmet in a container;
with this patchset each container can have its own configuration, and
one can simulate a multi-node nvmet cluster using containers.

How it works:
The configfs 'root' entries are stored in 'configfs_super_info', which
can be looked up from an xarray using the (network) namespace ID as the index.
A configfs subsystem can be converted to be namespace aware by implementing
the new subsyste callbacks 'fill_subsystem()' and 'clear_subsystem', which
are responsible for populating the subsystem structure.
Upon registration via 'register_subsystem()' the subsystem is put in a
linked list within 'configfs_super_info'. So when mount() is called from
a different namespace this list is traversed, and new subsystems are created
in the new namespace using the callbacks.

Open Issues:
- I've added a new function 'mnt_clone_direct()' to clone the vfsmount
  entry (the original code just did a simple_pin_fs()). Not sure if
  that's correct. Christian?
- Ideally I would love to make the whole thing work without having
  to mount a new configfs instance from within the container.
  Again, not sure if that's possible.
- I've decided to base it off the net namespace (and not any namespace).
  That makes implementation easier, but requires the various subsystems
  to actually _use_ the network namespace.
  The current use-case (nvmet) does that, so it works for me :-)

Otherwise, as usual, commands and reviews are welcome.

Changes to the original submission:
- Changed to use 'net' namespace instead of 'mnt' namespace
- Smaller fixes as suggested by sashiko.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
Hannes Reinecke (12):
      fs/configfs: rework configfs_is_root()
      fs/configfs: dynamically allocate super_info
      fs/configfs: separate out configfs_{link,unlink}_root()
      fs/configfs: add superblock as attribute to configfs_pin_fs()
      fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
      fs/configfs: add superblock as attribute to configfs_pin_fs()
      fs/namespace: implement mnt_clone_direct()
      fs/configfs: switch to get_tree_keyed()
      fs/configfs: open-code simple_pin_fs()
      nvmet: make discovery subsystem dynamic
      nvmet: per net-namespace port list
      nvmet: make configfs setup namespace aware

 drivers/nvme/target/configfs.c  | 203 ++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      |  36 +++---
 drivers/nvme/target/discovery.c |  91 +++++++++++----
 drivers/nvme/target/nvmet.h     |  15 ++-
 drivers/nvme/target/tcp.c       |   6 +-
 fs/configfs/configfs_internal.h |  23 +++-
 fs/configfs/dir.c               | 183 ++++++++++++++++++++++++-----
 fs/configfs/mount.c             | 248 +++++++++++++++++++++++++++++++++-------
 fs/namespace.c                  |  11 ++
 include/linux/configfs.h        |   8 ++
 include/linux/mount.h           |   1 +
 11 files changed, 668 insertions(+), 157 deletions(-)
---
base-commit: 66affa37cfac0aec061cc4bcf4a065b0c52f7e19
change-id: 20260619-configfs-ns-b5748b366366

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>

