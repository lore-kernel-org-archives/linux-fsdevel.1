Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564209;
	b=btwbk6+zNlLQOQlANv++drvSkoFoBANLzfru9CvFiC9+K9LXPezO+EuEAxw/v+Uj57mp
	 2lCbdmaXPfie4OZRt3FeZPLyfJrbdcYc7i7YE7TM+otb1/zTAQEaWDkMPaZi+hVQSRYoz
	 IxpJqseurSGe73YxgjtrZBjJFJz6VjzoQgGsrXG8jm0Py5jeR/lWruuXmA0nQh0caeXcM
	 FaDaNpwbdwF05cw8p+mnSXeog+hvtCqbAG9A2xWfbPFkIWYOFimiN9uSVAopqwST1C+J/
	 pofAxGgDhkI8QojFfusoo+DfNzpDOTiY14vtCDIw6TjVUsz6qlxDb9NNYSWV08AF8Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=f3rKnzeXmPTjVNP6fPu4kFAyMWVVj9CVo0hSntZlMr0=;
	b=WREM8chlgvIfmZ1XIYn9jL/kxFvMZKF9I7l+dBkViO7A3NxIhjsMfAgmY5GsFzdrNCE9
	 9Qo8EH6is1C8iqBT1GGrG5EEFqK7fNyGmLNLowjCejePz3FVSLQSku6sIrBqrRRaDamH4
	 X2ZwTUJ+JAcaZDG0LpQKIok3vXyvoFfzPZq2sDJFnIWaxVeZgKhUMqc7VpRI9KSFx09uJ
	 hr5tphP651bSJFUDBMHWefEczvPbkq5eGamTRrD9aJr25P7kXpqny7aW9GLDUwvqEIvqw
	 UH4j1mnlZADorsA2Zkh9iMemnrEVvzvMdbq3P5rq3AW/+2PtOgBXdK57B4oSpqdzOqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWufY5QG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D860A383F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661D860A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWufY5QG
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53644ab1f7bso11490371cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794564207; cv=none;
        d=google.com; s=arc-20260327;
        b=WcxhJ9iPA2tenXuFPRy4lhFWqH66NSNektBTE71osZC2THoPq3mUus8a7l8kdhFro9
         1X+H0fOYepWQ831dzM/hKlpCeIQumS+Xu/PK0ATB9mKOMSAafm65X+ARdWRewP4QmUcs
         0SCJ8LcA4ZkhDu8Kg6Dx9G7s0PJDChnc+thG+S+61MsqZRV2liN563slZAHTG+o9pPQ6
         BHzR4AgMzbFAs2hbQXAt2W5rrhH0UplzgUPdCxaN/WMBYQ8gXHmJyiyCl4uhZDsvCyOa
         AEXDa5Ao5u4RcApM1Dty27vTNwxBvonh+BDGabc60yo2O+DW5t94RmoREuCEVhgpoZXs
         CqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=f3rKnzeXmPTjVNP6fPu4kFAyMWVVj9CVo0hSntZlMr0=;
        fh=xk15yXIGYiHiI8RtrfiMuvv2GCn+RqTv383WLPTpIqc=;
        b=lKe7GWDFXaKWtqX8IGlhOhnAScKb4c80BhqTMYjMZRvJG5ZRneyAHLK05KqFgq/VQz
         9udfHiEF/LUh+E336kI2nFbCUczXw3xjAi26iK1TuxGhVB0FJpEx0X8bd5tPBUz0t2YM
         lCz3mbnfzpEcvxd+6FzUa9EA/UxMOxliUB89IpyNtPTzantqgU4JIsxQDvKjqHqe2qB8
         XZaCCNaDliyrxze9NSrpJed3zjSEasxo3EH0ssEcTdmLrNjK2jSXGWcong5ufMJOnxWz
         u9+wYpErlN2PFUMe/0u/LuYy0MaCiDei8bYHlwGSxm2f9j6mHg0o88yk3rxtqALggpWD
         3Fjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794564207; x=1795169007; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3rKnzeXmPTjVNP6fPu4kFAyMWVVj9CVo0hSntZlMr0=;
        b=uWufY5QGKv/F+pdDNNbl+uRXtwZsvz2Fkx5tpJib81bfTphB+S8d/ghtKdugaueicv
         9tYOxpt0DD1/WSpGONMyy8uLvwAPSBld2SJxx7MkQ0N2Uzzo4O8Cnh64AfafE5FEDRXc
         erSFYxN0IQiZc5eu9HloWsURg91WA69e/kDKwaBu3zTaA4AxaccaY7IGb+CcJ3jXWjen
         +x719fyH5va0Al3giFmkV4nHY1j1a34g0MK8kFIGI7sVM/HrsgAgRanICUJbhjZHos4N
         rVF47A5NvWjV7QKU1Ril5M9MTl9o0G1sHKt/aZ6rw1ecUdx9EfWk/fWifmpqVfkqjm+z
         53HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564207; x=1795169007;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f3rKnzeXmPTjVNP6fPu4kFAyMWVVj9CVo0hSntZlMr0=;
        b=zzTqW5HdtvpYPNpGeYtgfhuB7QkjlRbptFX/VHyqzAN8yZulBZoq7Ve/3X/e7oj52a
         KHJN6FI3ZBrIDoNUZKHF70jAovGYiqyJrOdFwLPktWW9PoeLjFEQDRo1oJX13GUlbElf
         4g1J0wLR1beOA5hQ3cRaT44IVRNSswpF2qph7LEiSRDLTOltuqrqqdVgGTt2hHCIRZFT
         WUQ9zT/Kr/3F4XWxuEllI1ePwWGZWEkMsByZxlCsU5sJe9jL3G7kGlfTe/oVFjtb7lV3
         qgM4WRpU/4Pc2bMJqacoaOAgX2qtuzHSL6phLEe9pnsrZREIdA/myK56XtrNjYIV32CS
         MpFw==
X-Forwarded-Encrypted: i=1; AL+hErEpp82EnhMNxY/ldgcTuRSUFmXBveafsahhDR+QBAxFhE2hMgiVAWx7CcqbAwkTFgoUZbf5hHJIfxjCkftt@vger.kernel.org
X-Gm-Message-State: APuU4Z94cmELJpZYy7V+0zPogVcApeNP+C51BZNeI8a2BVZG4XYP6h7x
	8YE4Z0GRNwLG9xH/KGg6QBDSbjoQuY3qGIEsdDwfSWmpDoztLT3MmTqbBlZ0O1d7awJPxgU240n
	iNUZ3kfcCj+9w3y7lmFT+dHdipdSH6rg=
X-Gm-Gg: AYBFou0QSfGV4vrmlvRZc3q2Er4rEQvHQ8gUkF+1koQi19H5BacVr0yBHgeh7N9HFtW
	4SjSkmv2dOfitMaIqd/GhYePubsboN2svwyk1IpGWZIABtztNAMt0ckkIuA/+yJo92/3RrwpQR9
	xuXdlwjGRbr8sI2xAkI3PKjgury9tqWKYy2nrf9ztTm9tDoSaQpkFm0/XWsR7Xw1R5hEmWjc8TX
	PLLPPkLRXzrt8kS47rGosuPf04awvSvQ8x75PCcxxlKvYdFDbj+Rvn7tlweXQBy6zLwXWEhUBfE
	zJWBIEkPVP3p5xeZiv/gTBXdUk4eWK1g+LZg31j7oVNm+bEg+iCK3NqnYyHCOJCFrz1N2Zsg3eP
	DOt6/PQb745vQloX0fcDfotdO1d45eujR6IaD
X-Received: by 2002:a05:622a:5446:b0:535:70b4:3f86 with SMTP id
 d75a77b69052e-55ac9e59bb4mr29783671cf.76.1794564207053; Fri, 13 Nov 2026
 02:03:27 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Hristos Nenkov <nenkov2004@gmail.com>
Date: Fri, 13 Nov 2026 11:03:15 +0100
X-Gm-Features: AclHuK_9m7WQNlxFW7kCm3i_5qb6-LzCoS-_xPEfDmcl2bQBqfwAi34Sqeb7WTY
Message-ID: <CAO7_G+ypR12OwOiwnrqXDAC9zoboTMn_qLoASfJqYP3H83Vk5A@mail.gmail.com>
Subject: [RFC PATCH] fuse: preserve daemon-owned ACL permission decisions
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Seth Forshee <sforshee@kernel.org>, 
	Lakshita Jain <lakshita.jain@databricks.com>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Legacy FUSE daemons without default_permissions or FUSE_POSIX_ACL can
make their own permission decisions. Generic ACL ownership checking
prevents non-owner ACL writes and removals reaching these daemons,
including operations associated with sed -i and install -m.

Introduce an opt-in inode-operation flag so FUSE can make the ownership
decision in its ACL callback. Retain owner/capability checking for
default_permissions and negotiated POSIX ACL mode, and leave the generic
ownership check in place for filesystems that do not opt in.

Enforce the FUSE mount caller restriction and wait for channel readiness
before reading negotiated policy, including requests on the mount root.
The wait follows existing request-allocation publication, interruption,
freezer and abort-accounting conventions.

Fixes: 318e66856dde ("xattr: use posix acl api")
Link: https://lore.kernel.org/all/CALE1rk6tGt_Pe7CpFL1NSTgugVpXLH_iguO2D9VsAVHn1p-02w@mail.gmail.com/

Signed-off-by: Hristos Nenkov <nenkov2004@gmail.com>
---
Hi Christian, Miklos, Al, Jan and Lakshita,

I reproduced Lakshita's report with libfuse 3.14.0 on WSL 6.18.58.1,
including both setting and removing an access ACL, and prepared this
candidate for design review.

I built baseline and candidate kernels from
f66469d9905b39d2c260a15d7d6db450f4db67c1 (7.4-rc1) with a minimal x86_64
configuration and booted both under QEMU TCG. The expanded matrix
completed 100 baseline assertions and 101 candidate assertions with
zero mismatches. The baseline confirms the expected original EPERM;
the candidate forwards legacy non-owner requests to the daemon while
retaining the tested kernel-managed restrictions.

The matrix covers access/default ACL set and removal, owner/non-owner
callers, default_permissions, negotiated FUSE_POSIX_ACL, daemon rejection,
malformed ACLs, read-only mounts, root requests without allow_other,
and a root ACL request observed pending before daemon initialization.
That observation identifies the syscall, not the exact kernel wait site.

Checkpatch completed with 0 errors, 0 warnings and 0 checks. A final
two-line indentation adjustment produced a byte-identical dev.o; the
packet's source, guest and image hashes were checked against the build
and VM receipts.

The test daemon acknowledges operations without storing ACLs, so this
does not establish ACL persistence or candidate passthrough sed/install
behavior. Newer upstream, namespace/idmap, LSM and wider other-filesystem
testing remain outstanding. I can provide the VM harness and serial
logs if useful.

I used OpenAI Codex to trace the supplied report and draft the changes,
VM harness and message. I ran the Linux builds and VM tests locally.
A separate-context AI review identified initialization and caller-policy
gaps in the first local proposal; this candidate includes corrections
and the additional boundary controls. No human Reviewed-by or
maintainer approval is claimed.

Would this opt-in flag be an acceptable way to express the ownership
policy, or would you prefer a different VFS interface? In particular,
the placement of the ownership decision relative to generic ACL
validation, and the readiness helper, need review. This is an RFC,
not a request for immediate merge.

Thank you for your time.

Best regards,
Hristos Nenkov

diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -627,6 +627,8 @@
 #define IOP_CACHED_LINK                0x0040
 #define IOP_FASTPERM_MAY_EXEC  0x0080
 #define IOP_FLCTX              0x0100
+/* ->set_acl() is responsible for the ownership check. */
+#define IOP_ACL_OWNER_CHECK    0x0200

 /*
  * Inode state bits.  Protected by inode->i_lock
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -949,7 +949,8 @@

        if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
                return acl ? -EACCES : 0;
-       if (!inode_owner_or_capable(idmap, inode))
+       if (!(inode->i_opflags & IOP_ACL_OWNER_CHECK) &&
+           !inode_owner_or_capable(idmap, inode))
                return -EPERM;

        if (acl) {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -433,6 +433,8 @@
                                   new_decode_dev(attr->rdev));
        } else
                BUG();
+       /* ACL ownership policy depends on the negotiated connection mode. */
+       inode->i_opflags |= IOP_ACL_OWNER_CHECK;
        /*
         * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
         * so they see the exact same behavior as before.
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -5,6 +5,7 @@
  */

 #include "fuse_i.h"
+#include "dev.h"

 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
@@ -101,6 +102,20 @@
        if (fuse_is_bad(inode))
                return -EIO;

+       if (!fuse_allow_current_process(fc))
+               return -EACCES;
+
+       ret = fuse_chan_wait_ready(fc->chan);
+       if (ret)
+               return ret;
+       if (fc->conn_error)
+               return -ECONNREFUSED;
+
+       /* Legacy daemons without default_permissions decide ownership. */
+       if ((fc->default_permissions || fc->posix_acl) &&
+           !inode_owner_or_capable(idmap, inode))
+               return -EPERM;
+
        if (fc->no_setxattr || fuse_no_acl(fc, inode))
                return -EOPNOTSUPP;

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -107,6 +107,25 @@
                /* wake up aborters */
                wake_up_all(&fch->blocked_waitq);
        }
+}
+
+/* Wait for channel negotiation before using connection-dependent policy. */
+int fuse_chan_wait_ready(struct fuse_chan *fch)
+{
+       int err = 0;
+
+       atomic_inc(&fch->num_waiting);
+       if (fuse_block_alloc(fch, false)) {
+               err = -EINTR;
+               if (wait_event_state_exclusive(fch->blocked_waitq,
+                                              !fuse_block_alloc(fch, false),
+                                              (TASK_KILLABLE |
TASK_FREEZABLE)))
+                       goto out;
+       }
+       err = READ_ONCE(fch->connected) ? 0 : -ENOTCONN;
+out:
+       fuse_drop_waiting(fch);
+       return err;
 }

 static void fuse_put_request(struct fuse_req *req);
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -36,6 +36,7 @@
 unsigned int fuse_chan_num_waiting(struct fuse_chan *fch);
 void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc);
 void fuse_chan_set_initialized(struct fuse_chan *fch, struct
fuse_chan_param *param);
+int fuse_chan_wait_ready(struct fuse_chan *fch);
 ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args);
 int fuse_chan_send_bg(struct fuse_chan *fch, struct fuse_args *args,
gfp_t gfp_flags);
 int fuse_chan_send_notify_reply(struct fuse_chan *fch, struct
fuse_args *args, u64 unique);
