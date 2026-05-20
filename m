Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6F1B4F0A
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304743; cv=none; b=Dl7lmlf+xVZ2HA0qVGZCrszm0g/0hFPXh88e6gD0kTR70t8f9dhN+EKKIcoN5svTWlnYAXLDgLMNVQ/D60Tx/yi73Jfv1CbjqSegv6gRMkdKE7PhbVTls6iKvcxIrvkGQyo7GpnSz85I7m3NGEUf95ZRno4eLaOTROLOue5Tq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304743; c=relaxed/simple;
	bh=DDN6XDxvcCU5fDxCWpLEYG53qrXGdlsJY1qCyYZeB10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SY/R56R7YvnIpJ7NDKCxY9/VMNwCdN5fnd/uT98NBN5qGD6/813KAxho0ZwLVu6zTn45myAabCFG0clG88sCY/1k3beW+EgbBh1hbfP4XgW0XlucPZVG5tk/rXTiNHILerfGkFLMBNrSBnM1WBHXBE0RFxodwuEKkecABTyJ8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=KNE6zt5S; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="KNE6zt5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779303832; h=from : subject
 : to : message-id : date;
 bh=LVAjlRvJ0GkGfrBEy8PvqJhPIKXbAVEbrDEErYfGT1g=;
 b=KNE6zt5SE0jiHWHeJipdH2RiSXXqqPrHb3mIUIfmiXtClfIyxq6tFaz0Pe6dLtNTa3ao8
 zHKGLekzvYhSj6JAHVjbEt6YjNDJEMqjWYkiTup6F8l9egOVetQ73M7avmY59a744We3kbu
 a9WHydczuCkhbtWe23mD9EeQ8TOdENU38V9aTEDiqJgBkhuCl+kK8ElgkCI9IJLnlKMhPSj
 IHi/khDylzM2OoQHA6YX979l8dreY9Vdsvl1RwcgQGM4h3aWxCOyWS4VPS8WIkli/7iukkz
 Orlj3F7Sao9FLjRJ7y2zw9NFrOGmEaBYi13z5J6xvwr+XLvkd/LjFxTQVrLg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wPmCr-4o5NDgrlNh0-l1sw;
	Wed, 20 May 2026 19:03:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 0/4] 9p: Performance improvements for build workloads
Date: Wed, 20 May 2026 20:41:36 +0200
Message-ID: <cover.1779302002.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s2udruuJ1Q
X-smtpcorp-track: 2hOTId8oljB0.5Sq56-DekucR.0Rfu7ACRjkw

This patchset introduces several performance optimizations for the 9p
filesystem when used with cache=loose option (exclusive or read only
mounts). These improvements particularly target workloads with frequent
lookups of non-existent paths and repeated symlink resolutions.

The very state of the art benchmark consisting of cloning a fresh
hostap repository and building hostapd and wpa_supplicant for hwsim
tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
(with trans=virtio,cache=loose options) has been used to test those
optimizations impact.

For reference, the build takes 0m56.492s on my laptop natively while it
completes in 2m18.702sec on the VM. This represents a significant
performance penalty considering running the same build on a VM using a
virtiofs rootfs (with "--cache always" virtiofsd option) takes around
1m32.141s. This patchset aims to bring the 9pfs build time close to
that of virtiofs, rather than the native host time, as a realistic
expectation.

This first three patches in this series focus on keeping negative
dentries in the cache, ensuring that subsequent lookups for paths known
to not exist do not require redundant 9P RPC calls. This optimization
reduces the time needed for the compiler to search for header files
across known locations. The two first patches introduce a new mount
option, ndentrycache, which specifies the number of ms to keep the
dentry in the cache. Using ndentrycache without value (i.e. keeping the
negative dentry indifinetly) shrunk build time to 1m46.198s. The third
patch enable the negative dentry caching for 24 hours by default on
cache=loose.

The fourth patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-3): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-4): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Changes since v5 (address relevant sashiko.dev remarks):
  - Replace forgotten ndentrycache with negtimeout wording in
    documentation
  - Rework v9fs_issue_read() to perform proper offset and length
    validation, remove PAGE_SIZE truncation, and use the actual copied
    length rather than the expected one.
  - Use d_find_any_alias() instead of d_find_alias() to avoid unhashed
    dentry race in v9fs_init_request().

Changes since v4:
  - Fix potential uninitialized access in v9fs_issue_read() and
    v9fs_vfs_symlink_dotl()
  - Fix potential memory leak in v9fs_issue_read()

Changes since v3:
  - Go back to s32 ndentry timeout option, rename it to negtimeout so
    its easier to grep
  - Bring back the missing 4 letters for *_TIMEOUT_* macro name
  - Fix some alignment/space issues

Changes since v2:
  - Rename v9fs_dentry_is_{expired,refresh} to ndentry
  - Some grammatical fixes in couple of comments
  - Rename the negative cache mount option to ndentrycache. Using
    ndentrycache without value enable infinite caching while
    ndentrycache=<time> enable caching for <time> milliseconds.
    This allows the option to be unsigned.
  - Make it more obvious v9fs_issue_read() is only called on dotl
    symlinks

Changes since v1:
  - Rebase on 9p-next (with new mount API conversion)
  - Integrated symlink caching with the network filesystem helper
    library for robustness (a lot of code expects a valid netfs context)
  - Instantiate symlink dentry at creation to avoid keeping a negative
    dentry in cache
  - Moved IO waiting time accounting to a separate patch series

Thanks.

Remi Pommarel (4):
  9p: Cache negative dentries for lookup performance
  9p: Add mount option for negative dentry cache retention
  9p: Set default negative dentry retention time for cache=loose
  9p: Enable symlink caching in page cache

 Documentation/filesystems/9p.rst |   5 ++
 fs/9p/fid.c                      |  11 ++--
 fs/9p/v9fs.c                     |  27 +++++++-
 fs/9p/v9fs.h                     |  28 ++++++---
 fs/9p/v9fs_vfs.h                 |  15 +++++
 fs/9p/vfs_addr.c                 |  47 +++++++++++++-
 fs/9p/vfs_dentry.c               | 105 ++++++++++++++++++++++++++-----
 fs/9p/vfs_inode.c                |  18 +++---
 fs/9p/vfs_inode_dotl.c           |  60 +++++++++++++++---
 fs/9p/vfs_super.c                |   1 +
 include/net/9p/client.h          |   2 +
 11 files changed, 271 insertions(+), 48 deletions(-)

-- 
2.52.0

