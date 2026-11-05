Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898391;
	b=dH8KlvQimYrznnQZDRxvXDxbMMgkwXFV4rYqllAi6yfC7uYG3QmbNPcJMxOHdVUVi+Ep
	 cF0bF4c4duzHO6NE0Yuc/ZYgFVtdlQEr4zpxf3lsIpgEqebIj/gTydKrBOorHwoEWxTDb
	 4xr4xipydMxbU7Nk+dh5oZFqFdCIP8OLfsFKghiwPdFp2rL6rDrDfIl8Y7DcUzvI1Er7w
	 AdI76tQUM+vvIqLvYjPzfR94ysu6qdhdr0sWcqn/hqBN1CBRVqRHfzpYE3b3FtihOo7hh
	 XVV1evU1Qt2oZHfhC48i9/OJS5AR0cPi8tO1NfEtjfIBvn8ABiDpWvghgzJntAjXwvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898391;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=YOVRkJDbL+kzQtBbxk8i8tvbE97kKOYz5DmVXXDV7YY=;
	b=AlcSHHCFO2EDoWL6HjsQZmNCcrN72y6SNmCyk4rHUzl1cEo/XL4LYlwT1wTNi37zOQ44
	 ZRkcO/eNW2cUiE0HLVH4w5q4ccPxd9AobCFrTUN8lNL4c1WjSW5HipIFuF4SdwYLBCWT9
	 sB4EcF/FroQXt8YIrOjgU4FJnnlwmox8X1dTVVJP3E540bBlKsIdTzNc9xbiPCAUbPsX1
	 VFOJ5zogldJZ2BKX0bHlMeF0zLVTDxPokJfAPVst2Qo40udNo0fzCVEqT9aeq7mJQNaDp
	 eMAlKxbeGfom8d6TM0Of+ISYnAtU1DuhJ6ZZDYbFuGlsuOjJJlu+fp+k+Ubc5miekpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=sL+qmzn+;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2204606A329;
	Thu,  5 Nov 2026 17:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2204606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=sL+qmzn+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1793898387; bh=7u/njVwV0biwoV3Ut4NN7XxBqu3R3HWWSpzR7UP47xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL+qmzn+cVUIOd08uEts2SPGAqOQKIrscPyHdhW3OAulii9vX1o5aiJBNenNR+rjq
	 Dy9k4/p/1w1jSBifF+BCvXvD5zm8ttyB5CrarKpxL7lJMOnGQL+smmVrXLGWJtKday
	 wa8GvrVMpG7YTaiZZhuk+kmfZFasn7GsUMlH7fOm+udukUbdO9CwVVkQpJ7y9TG0Kl
	 Hl28IVXBJpF7GnvJ1YctHBqIihrx5LUbf5I/l434aCnMwzlL+TcpoY4Q+JmBz5Ihjj
	 oI2O6pwa55+xscmQClQZPoIzSXfxc2Nl0/T//1y8qVYbS42DyWaQ7mw5xwHY6u0Tj5
	 +GUfipWOFGn1w==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0710A1A0B; Thu,  5 Nov 2026 11:06:27 -0600 (CST)
Date: Thu, 5 Nov 2026 11:06:26 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Andrew Halaney <andrew@amutable.com>,
	Jeremy Bingham <jbingham@gmail.com>,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>,
	Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/90] Documentation: add a design document for
 cells
Message-ID: <auy3kgm1YytennDE@hallyn.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
 <20261105-b4-cells-v3-1-bc9095937a84@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-b4-cells-v3-1-bc9095937a84@toxicpanda.com>

On Thu, Nov 05, 2026 at 02:56:52PM +0000, Josef Bacik wrote:
> A container on Linux is not an object. It is eight kinds of namespace, a
> cgroup, a seccomp filter and a set of conventions that a runtime holds
> together. The kernel cannot name the result, kill it as a whole or account
> for it.
> 
> A cell is a container as a single kernel object. A task is born in a cell
> and never leaves it, and no existing task can enter one. A cell is built
> from the outside: the builder fills named slots from file descriptors that
> it holds, seals the cell, and then spawns tasks into it. Holding the
> cellfd is the authority to do all of that.
> 
> Start the series with the design document. It describes what cells are
> for, which invariants they uphold, how they are used, and what this
> implementation does not do yet. The following patches refer to it.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  Documentation/userspace-api/cells.rst | 861 ++++++++++++++++++++++++++++++++++
>  Documentation/userspace-api/index.rst |   1 +
>  2 files changed, 862 insertions(+)
> 
> diff --git a/Documentation/userspace-api/cells.rst b/Documentation/userspace-api/cells.rst
> new file mode 100644
> index 000000000000..76ce5267fdb6
> --- /dev/null
> +++ b/Documentation/userspace-api/cells.rst
> @@ -0,0 +1,861 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====
> +Cells
> +=====
> +
> +A cell is a container as one kernel object.  A task is born in a cell and never
> +leaves it, and nothing can enter one.  A cell is built from the outside: the
> +builder fills named slots from file descriptors it holds, seals the cell, and
> +spawns tasks into it.  Holding the file descriptor of the cell, the *cellfd*, is
> +the authority to do all of that.
> +
> +This document explains why cells exist, what they promise, how they are used and
> +what the first implementation does not do yet.
> +
> +.. contents:: :local:
> +
> +
> +Why
> +===
> +
> +A container on Linux is not an object.  It is eight kinds of namespace, a cgroup,
> +a seccomp filter and a set of conventions that a runtime holds together.  A number
> +of problems follow from that, and they do not go away by fixing bugs one at a
> +time.
> +
> +There is nothing to name.
> +  The kernel cannot say which container a task is in, cannot kill a container in
> +  one operation and cannot tell what a container has access to.
> +
> +Membership is a property of a task at a moment.
> +  ``setns()`` and ``unshare()`` let a task change one namespace at a time.  A task
> +  that is half way between two sets of namespaces, holding file descriptors, a
> +  working directory or a memory map from one side and credentials from the other,
> +  has been the source of many bugs.
> +
> +Setup runs on the inside.
> +  A runtime forks, and the child sheds, one call at a time, what it inherited and
> +  should not have.  What it forgets to shed leaks into the container.
> +
> +Privilege hangs off ids.
> +  A user namespace gives its creator a full set of capabilities over everything
> +  the namespace owns,

Yes this was explicitly one of the 4 user namespace design goals,
and I don't really want code running on my system that I can't
later control.

>  which puts a large amount of code that was written for root
> +  within reach of every user.

You imply that cells don't do this, but the capabilities section below suggests
otherwise.

>   Who may do what to whom is decided by comparing
> +  uids,

It's also decided by namespace targeted capabilities (and LSM
credentials).

>  and whether two uids are the same depends on how several runtimes agreed
> +  to carve up ``/etc/subuid``.

Well, you are adding one more runtime (https://xkcd.com/927/ :)  This
particular problem would be better solved using a subuid NSS module.

> +Hiding is done by mounting over.
> +  What a container must not see is commonly covered by a mount.  ``MNT_LOCKED``
> +  exists to keep such mounts in place, and a way to remove one, or to copy the tree
> +  without it, reveals what it covered.
> +
> +A cell turns this around.  There is one object with one lifetime.  What it holds
> +was put there explicitly, by somebody who held it.  What was not put there is not
> +there.

Of course userspace could do this now - create a userns, create an mntns,
set up the mounts, and then create another userns with identity uid mapping,
so then the container cannot get ns_capable(mnt_ns->userns, CAP_SYS_ADMIN) to
unmount.

I can envision this being a good strategy for sandbox style runners.

> ...
> +Capabilities
> +------------
> +
> +A legacy user namespace hands its first task every capability there is.  A cell hands
> +out none.

This seems misleading.  It hands any that you want, you just have to specify
them differently, right?

>  **Being uid 0 of a cell comes with nothing**: it is one id of 65536, which
> +cannot become another, give a file away or signal a task that runs under another id.
> +
> +What the tasks of a cell are to have, the builder names in the ``caps`` slot: a ``__u64``
> +with a bit for each capability, by its number in ``<linux/capability.h>``.  Every task
> +that is started in the cell has them permitted and effective.  They are its bounding set

Every task?  But you do say setuid() drops them as usual.  Are you saying
that the first process is uid 0, and capability inheritance just works
as usual?  If not, then some examples would be helpful - and in that
case it sounds like this would be an unexpected method of operation
which would confuse userspace (which can be dangerous).

> +too, so that is all anything in the cell will ever have:
> +
> +* Every task has ``no_new_privs``.  It gains nothing from a file, or from being uid 0
> +  when it runs one.
> +* No task of a cell can make a user namespace, to have a full set in.
> +* A capability that a task has let go of is gone for that task and its children.
> +
> +Letting go works as ever.  ``capset(2)`` takes nothing, leaving uid 0 behind with
> +``setuid()`` costs all of them, and ``PR_CAPBSET_DROP`` does not take ``CAP_SETPCAP`` in
> +a cell.  It does elsewhere lest a program that gains from its file runs with less than it
> +counts on, and in a cell there is no such program.
> +
> +The capabilities are over the user namespace of the cell.  They are good for the ids of
> +the cell, for the files that belong to those in a tree that is mapped for the cell, for
> +its tasks, and for what else that user namespace owns: its uts, ipc and pid namespace.

It seems to me most of the bugs relating to capabilities in user
namespace were not about the privilege leaking, which you seem to
suggest here, but rather about kernel code under an ns_capable()
check being reachable when, without unprivileged user namespaces,
unprivileged users could not have reached them.  Since you open quite
a few capabilities for instance with net_may(), that code is still
reachable.  So you are probably reducing the reachable code, which
is good, but the above is over-stating it.

Also I would continue to be careful about uid mapped filesystems.  If
the host creates a cell with host uid 0 mapped to uid N in the
cell, can a cell process chmod u+s the file, and collude with an
unprivileged host process to run it as host-root?

> +They are good for nothing else, which is why naming them takes no privilege.  The mount
> +namespace is not the cell's, so no capability lets a cell mount.  Nor is the network
> +namespace, see `Rights over the network`_.
> +

So what is your goal here?  You list several properties of the current
namespaces implementation, and imply that they are a problem.  But what
is the final goal: is it to implement a security sandbox that is
stronger than what you can currently build from userspace?  That's the
impression I get.  Or is it to avoid bugs in userspace, by simplifying
what userspace needs to do?  Knowing the goal will help review the
patchset.set.

Also, how does this jive with criu?  Is it introducing any cell identifiers
that can't be recreated?  I believe that historically that has been the
biggest blocker to a "container" like object in the kernel.

-serge
